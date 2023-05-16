//
//  GiftRevenueView.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 24/04/2023.
//

import SwiftUI

struct GiftRevenueView: View {
    @Environment(\.presentationMode) var presentaionMode
    
    @State var selectedDate = Date.now
    @State var presentDatePicker = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                HStack(spacing: 16) {
                    Button {
                        presentaionMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackButton")
                    }
                    
                    Text("Gift Revenue")
                        .font(.urbanist(name: .urbanistBold, size: 24))
                    Spacer()
                }
                .frame(height: 30)
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 24){
                        GiftRevenueHeaderView()
                        
                        DailyLimitView(title: "Daily withdrawal limit", balance: "$ 1,000")
                        
                        DailyLimitView(title: "Remaining withdrawal today", balance: "$ 300")
                        
                        TransactionsHeaderView()
                        
                        DailyLimitView(title: "Earned $ 3,500", balance: "Withdrawal $ 300")
                        
                        VStack(spacing: 0){
                            GiftRevenueTransactionRowView()
                            
                            GiftRevenueTransactionRowView()
                        }
                        
                        Button{
                            withAnimation{
                                presentDatePicker.toggle()
                            }
                        } label: {
                            DatePickerButton()
                        }
                    }
                    .padding(.top, 33)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .navigationBarHidden(true)
            
            if presentDatePicker{
                GiftRevenueDatePickerView(isPresent: $presentDatePicker, selectedDate: $selectedDate)
            }
        }
    }
}

extension GiftRevenueView{
    func DailyLimitView(title: String, balance: String) -> some View{
        HStack{
            Text(title)
                .font(.urbanist(name: .urbanistBold, size: 16))
            Spacer()
            Text(balance)
                .font(.urbanist(name: .urbanistBold, size: 16))
        }
    }
    
    func TransactionsHeaderView() -> some View{
        ZStack{
            Text("Transactions")
                .font(.urbanist(name: .urbanistBold, size: 20))
        }
        .frame(maxWidth: .infinity, minHeight: 41)
        .background(Color.grayNine)
        .cornerRadius(10)
    }
    
    func DatePickerButton() -> some View{
        HStack{
            Text("Jan/2022")
                .foregroundColor(.black)
                .font(.urbanist(name: .urbanistSemiBold, size: 14))
            
            Image("ArrowDownS")
            
            Spacer()
            
            Image("CalendarS")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, minHeight: 41)
        .background(Color.grayNine)
        .cornerRadius(10)
    }
}
