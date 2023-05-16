//
//  ManageAccountsViewComponents.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 23/04/2023.
//

import SwiftUI

struct ManageAccountsRowView: View{
    
    let rowType: ManageAccountsRowType
    let value: String
    
    @State var isEdit = false
    
    var body: some View{
        VStack{
            Button{
                withAnimation{
                    isEdit.toggle()
                }
            } label: {
                HStack(spacing: 20){
                    ZStack{
                        Image(rowType.icon)
                    }
                    .frame(width: 28, height: 28)
                    HStack(spacing: 2){
                        
                        HStack(spacing: 0){
                            Text(rowType.rawValue)
                                .font(.urbanist(name: .urbanistSemiBold, size: 18))
                                .lineLimit(1)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                        HStack(spacing: 0){
                            Spacer()
                            Text(!value.isEmpty ? value : rowType.placeholder)
                                .font(.urbanist(name: .urbanistSemiBold, size: 18))
                                .lineLimit(1)
                                .foregroundColor(!value.isEmpty ? .black : .customGray)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    ZStack{
                        Image(rowType.trailingIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 20, height: 20)
                }
            }
            
            if isEdit{
                ManageAccountsEditFieldView(placeholder: rowType.placeholder, isEdit: $isEdit, rowType: rowType)
                    .padding([.horizontal, .top])
            }
        }
    }
}

struct ManageAccountsEditFieldView: View{
    
    @State var inputText = ""
    let placeholder: String
    @Binding var isEdit: Bool
    let rowType: ManageAccountsRowType
    
    var body: some View{
        VStack(alignment: .leading, spacing: 3){
            Image("TriangleEP")
                .frame(width: 40, height: 24)
                .padding(.leading, 40)
            ZStack{
                RoundedRectangle(cornerRadius: 27)
                    .fill(.white)
                VStack(spacing: 0){
                    Spacer()
                    
                    TextField(placeholder, text: $inputText)

                    Rectangle()
                        .fill(Color.customGray)
                        .frame(height: 1.5)
                        .padding(.top, 1)
                    
                    Spacer()
                    HStack{
                        PrimaryFillButton(title: "Cancel", isIconExist: false, height: 24, font: Font.urbanist(name: .urbanistSemiBold, size: 10)) {
                            withAnimation{
                                isEdit.toggle()
                            }
                        }
                        .frame(width: 64)
                        
                        Spacer()
                        
                        PrimaryFillButton(title: "Save", isIconExist: false, height: 24, font: Font.urbanist(name: .urbanistSemiBold, size: 10)) {
                            withAnimation{ isEdit.toggle() }
                        }
                        .frame(width: 64)
                    }
                    Spacer()
                }
                .padding(.horizontal, 32)
            }
            .frame(height: 104)
            .overlay {
                RoundedRectangle(cornerRadius: 27)
                    .stroke(Color.purpleYellowGradient, lineWidth: 2)
            }
        }
    }
    
}

