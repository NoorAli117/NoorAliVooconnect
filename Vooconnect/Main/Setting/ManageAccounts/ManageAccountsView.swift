//
//  ManageAccountsView.swift
//  Vooconnect
//
//  Created by Vooconnect on 04/01/23.
//

import SwiftUI

struct ManageAccountsView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 16) {
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Image("BackButton")
                }
                
                Text("Language")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                Spacer()
            }
            .frame(height: 30)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 24){
                    Text("Account Information")
                        .font(.urbanist(name: .urbanistBold, size: 20))
                    
                    ForEach(ManageAccountsRowType.allCases, id:\.self){ type in
                        ManageAccountsRowView(rowType: type, value: "")
                    }
                    
                    Text("Account Control")
                        .font(.urbanist(name: .urbanistBold, size: 20))
                    
                    DeleteButton()
                }
                .padding(.top, 33)
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
}

extension ManageAccountsView{
    func DeleteButton() -> some View{
        HStack(spacing: 0){
            Image("DeleteS")
                .resizable()
                .frame(width: 28, height: 28)
            
            Text("Deactivate or Delete Account")
                .foregroundColor(Color.buttionGradientOne)
                .font(.urbanist(name: .urbanistSemiBold, size: 18))
                .padding(.leading, 20)
            
            Spacer()
        }
    }
}
