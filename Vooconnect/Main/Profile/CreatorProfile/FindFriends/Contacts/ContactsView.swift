//
//  ContactsView.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import SwiftUI
import MessageUI

struct ContactsView: View {
    
    @StateObject var contactsViewModel = ContactsViewModel()
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 24){
                ContactsNavBar()
                    .padding(.horizontal, 24)
                
                ScrollView(.vertical) {
                    if contactsViewModel.friendsList.count > 0{
                        VStack(alignment: .leading, spacing: 24){
                            Text("Your Friends")
                                .font(.urbanist(name: .urbanistBold, size: 24))
                            ForEach(contactsViewModel.friendsList, id:\.self) { user in
                                CreatorSearchCell(selectedSearchPagerType: .constant(.followers), user: user, onSwitched: ({ user in
                                    onSwitchedUserStatus(user: user)
                                }))
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    VStack(alignment: .leading, spacing: 24){
                        Text("Contacts")
                            .font(.urbanist(name: .urbanistBold, size: 24))
                        ForEach(contactsViewModel.contacts, id: \.self){ contact in
                            ContactsRowView(contactsViewModel: contactsViewModel, contact: contact)
                        }
                    }
                    .padding([.horizontal, .top], 24)
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func onSwitchedUserStatus(user: UserDetail){
        let index = contactsViewModel.friendsList.firstIndex { $0.uuid == user.uuid }
        if let index{
            contactsViewModel.friendsList[index].isSwitched.toggle()
        }
    }
}
