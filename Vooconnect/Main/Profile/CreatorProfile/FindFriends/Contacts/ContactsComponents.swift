//
//  ContactsComponents.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import SwiftUI
import ContactsUI
import Swinject

struct ContactsNavBar: View{
    var body: some View{
        HStack(spacing: 16){
            BackButton()
            Text("Contacts")
                .font(.urbanist(name: .urbanistBold, size: 24))
            Spacer()
        }
    }
}

struct ContactsRowView: View{
    var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    @ObservedObject var contactsViewModel: ContactsViewModel
    let contact: CNContact
    
    @State var isInvited = false
    @State var presentMessageView = false
    
    var body: some View{
        HStack(spacing: 8){
            Image(uiImage: contactsViewModel.getImage(contact: contact))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(30)
            
            VStack(alignment: .leading){
                Text(contactsViewModel.getName(contact: contact))
                    .font(.urbanist(name: .urbanistSemiBold))
                
                Text(contactsViewModel.getPhoneNumber(contact: contact))
                    .font(.urbanist(name: .urbanistRegular, size: 14))
                    .foregroundColor(.grayEight)
            }
            
            Spacer()
            
            if isInvited{
                ButtonWithBorder(title: "Invited", icon: "", isIconExist: false, width: 80, height: 32){ }
                    .padding(.trailing, 2)
            }else{
                PrimaryFillButton(title: "Invite", isIconExist: false, height: 32) {
                    presentMessageView.toggle()
                }
                .frame(width: 68)
                .padding(.trailing, 2)
            }
        }
        .sheet(isPresented: $presentMessageView) {
            MessageComposeView(recipients: [contactsViewModel.getPhoneNumber(contact: contact)], body: "https://vooconnect.com/\(userAuthanticationManager.userDetail?.username ?? "")") { messageSent in
                if messageSent{
                    withAnimation{
                        isInvited.toggle()
                    }
                }
            }
        }
    }
}
