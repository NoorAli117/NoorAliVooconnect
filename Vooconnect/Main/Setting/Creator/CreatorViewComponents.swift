//
//  CreatorViewComponents.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 24/04/2023.
//

import SwiftUI

struct AddCreatorPlanView: View{
    var body: some View{
        VStack(alignment: .leading, spacing: 25){
            Text("Create a plan")
                .font(.urbanist(name: .urbanistBold, size: 20))
        }
    }
}

struct AddCreatorPlanRowView: View{
    
    let rowType: AddCreatorPlanRowType
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
                            Text(!value.isEmpty ? value : rowType.placeHolder)
                                .font(.urbanist(name: .urbanistSemiBold, size: 18))
                                .lineLimit(1)
                                .foregroundColor(!value.isEmpty ? .black : .customGray)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Image("ArrowLogo")
                }
            }
            
            if isEdit{
                AddCreatorPlanEditFieldView(placeholder: rowType.placeHolder, isEdit: $isEdit, rowType: rowType)
                    .padding([.horizontal, .top])
            }
        }
    }
}

struct AddCreatorPlanEditFieldView: View{
    
    @State var inputText = ""
    let placeholder: String
    @Binding var isEdit: Bool
    let rowType: AddCreatorPlanRowType
    
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
                    
                    if rowType == .planImage{
                        ImageAvatarView()
                    }else{
                        HStack(spacing: 0){
                            Spacer()
                            
                            if rowType == .price{
                                Text("$")
                                    .font(.urbanist(name: .urbanistSemiBold, size: 16))
                                    .foregroundColor(.customGray)
                                    .padding(.trailing, 3)
                            }
                            
                            VStack(spacing: 0){
                                if rowType == .description{
                                    ZStack(alignment: .leading){
                                        TextEditor(text: $inputText)
                                        
                                        if inputText.isEmpty{
                                            Text(rowType.placeHolder)
                                                .font(.urbanist(name: .urbanistSemiBold, size: 14))
                                                .foregroundColor(.customGray)
                                        }
                                    }
                                }else{
                                    TextField(placeholder, text: $inputText)
                                        .font(.urbanist(name: .urbanistSemiBold, size: 14))
                                }
                                
                                Rectangle()
                                    .fill(Color.customGray)
                                    .frame(height: 1.5)
                                    .padding(.top, 1)
                            }
                            
                            if rowType == .price{
                                Text("/ Month")
                                    .font(.urbanist(name: .urbanistSemiBold, size: 16))
                                    .padding(.leading, 8)
                            }
                            
                            Spacer()
                        }
                    }
                    
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
            .frame(minHeight: 104)
            .overlay {
                RoundedRectangle(cornerRadius: 27)
                    .stroke(Color.purpleYellowGradient, lineWidth: 2)
            }
        }
    }
    
    func ImageAvatarView() -> some View{
        ZStack(alignment: .bottomTrailing){
            Image("profileicon")
                .resizable()
                .scaledToFill()
            .frame(width: 80, height: 80)
            .cornerRadius(10)
            
            Image("EditSquareEP")
                .resizable()
                .frame(width: 16.5, height: 16.5)
                .padding([.trailing, .bottom], 1.5)
        }
    }
}

