//
//  BalanceView.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 24/04/2023.
//

import SwiftUI

struct BalanceView: View {
    @Environment(\.presentationMode) var presentaionMode
    
    @State var navigateToGiftRevenue = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            HStack(spacing: 16) {
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Image("BackButton")
                }
                
                Text("Balance")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                Spacer()
            }
            .frame(height: 30)
            
            HStack(spacing: 0){
                Image("DollarS")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("DollarS")
                    .font(.urbanist(name: .urbanistBold, size: 16))
                    .padding(.leading, 8)
                
                Spacer()
                
                PrimaryFillButton(title: "Recharge", icon: "RechargeS", isIconExist: true, height: 30, cornerRadius: 15){}
                    .frame(width: 130)
            }
            
            Rectangle()
                .fill(Color.buttionGradientOne)
                .frame(height: 1.1)
            
            HStack(spacing: 0){
                Text("live Gifts")
                    .font(.urbanist(name: .urbanistBold, size: 16))
                
                Spacer()
                
                PrimaryFillButton(title: "$3.5K", icon: "GiftS", isIconExist: true, height: 30, cornerRadius: 15){
                    navigateToGiftRevenue.toggle()
                }
                .frame(width: 110)
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
        .navigate(to: GiftRevenueView(), when: $navigateToGiftRevenue)
    }
}
