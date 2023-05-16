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
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
//                    NavigationLink(destination: FillYourProfileView()
//                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $birthDayVM.birthDayDataModel.navigate) {
//                            EmptyView()
//                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Manage Accounts")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
//                    .padding(.leading)
                    
                    HStack {
                        Text("Account Information")
                            .font(.custom("Urbanist-Bold", size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    
                    VStack(spacing: 20) {
                        
                        HStack {
                            Image("CallMA")
                            Text("Phone Number")
                                .padding(.leading, 6)
                            Spacer()
                            Text("+1 111 467 378 ...")
                            Image("ArrowLogo")
                        }
                        
                        HStack {
                            Image("MessageMA")
                            Text("Email")
                                .padding(.leading, 6)
                            Spacer()
                            Text("andrew_ains...")
                            Image("ArrowLogo")
                        }
                        
                        HStack {
                            Image("CalendarMA")
                            Text("Date of Birth")
                                .padding(.leading, 6)
                            Spacer()
                            Text("12/27/1995")
                            Image("CalendarMA")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 17, height: 17)
                        }
                        
                        HStack {
                            Image("GroupMA")
                                .padding(.leading, 5)
                            Text("City")
                                .padding(.leading, 8)
                            Spacer()
                            Text("Los Angeles, CA")
                            Image("GroupMA")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 17, height: 17)
                        }
                        
                    }
                    .font(.custom("Urbanist-SemiBold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                    
                    HStack {
                        Text("Account Control")
                            .font(.custom("Urbanist-Bold", size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.top)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Image("DeleteMA")
                        Text("Deactivate or Delete Account")
                            .font(.custom("Urbanist-SemiBold", size: 18))
                            .foregroundStyle(
                                LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ManageAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageAccountsView()
    }
}
