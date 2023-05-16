//
//  CreatorView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct CreatorView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State var isAddPlanActive = false
    
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
                
                Button{
                    withAnimation{
                        isAddPlanActive.toggle()
                    }
                } label: {
                    Image("PlusS")
                        .renderingMode(.template)
                        .foregroundColor(isAddPlanActive ? .buttionGradientOne : .black)
                }
            }
            .frame(height: 30)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: 24){
                    Text("Become a Creator and offer premium content\nto premium subscribers\nCreate Monthly plans and choose what you share\nwith your premium subscribers")
                        .font(.urbanist(name: .urbanistMedium, size: 14))
                        .multilineTextAlignment(.center)
                    
                    if isAddPlanActive{
                        
                        HStack{
                            Text("Create a plan")
                                .font(.urbanist(name: .urbanistBold, size: 20))
                            
                            Spacer()
                        }
                        
                        ForEach(AddCreatorPlanRowType.allCases, id: \.self){ type in
                            AddCreatorPlanRowView(rowType: type, value: "")
                        }
                        
                    }else{
                        SubscriberPlanView()
                            .padding(.top, 28)
                    }
                    
                }
                .padding(.top, 33)
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
}
