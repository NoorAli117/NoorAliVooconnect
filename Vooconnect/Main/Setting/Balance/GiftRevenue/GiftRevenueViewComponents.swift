//
//  GiftRevenueViewComponents.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 24/04/2023.
//

import SwiftUI


struct GiftRevenueHeaderView: View{
    
    @State var lineLimit: Int? = 3
    var body: some View{
        VStack(alignment: .center, spacing: 8){
            Text("Total Balance")
                .font(.urbanist(name: .urbanistBold, size: 18))
            
            Image("squareTwoS")
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            Text("$3,500 USD")
                .font(.urbanist(name: .urbanistBold, size: 18))
                .gradientForeground()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .overlay{
            Rectangle()
                .stroke(Color.purpleYellowGradient, lineWidth: 1)
        }
    }
}

struct GiftRevenueTransactionRowView: View{
    var body: some View{
        VStack(spacing: 0){
            Divider()
                .overlay(.gray.opacity(0.5))
            
            Spacer()
            
            HStack(spacing: 0){
                Text("LIVE Gift Transaction")
                    .font(.urbanist(name: .urbanistBold, size: 16))
                Spacer()
                Text("+ $ 0.30")
                    .font(.urbanist(name: .urbanistSemiBold, size: 18))
                    .foregroundColor(.green1)
            }
            
            HStack(spacing: 0){
                Text("15/03/2022   21:07:51 PM")
                    .font(.urbanist(name: .urbanistBold, size: 16))
                    .foregroundColor(.grayTen)
                Spacer()
                Text("Balance $8.95")
                    .font(.urbanist(name: .urbanistSemiBold, size: 18))
                    .foregroundColor(.grayTen)
            }
            
            Spacer()
        }
        .frame(height: 70)
    }
}

struct GiftRevenueDatePickerView: View{
    
    @Binding var isPresent: Bool
    @Binding var selectedDate: Date
    
    var body: some View{
        ZStack(alignment: .bottom){
            Color
                .black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresent.toggle()
                }
            
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .frame(maxWidth: .infinity, minHeight: 250)
            .labelsHidden()
            .datePickerStyle(.wheel)
            .background(.white)
        }
    }
}
