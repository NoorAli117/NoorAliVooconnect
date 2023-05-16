//
//  HelpCenterView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct HelpCenterView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var fAQ: Bool = true
    @State private var contactUs: Bool = false
    
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
                    
                    // Back Button
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Help Center")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                        
                        Image("MoreOptionLogo")
                    }
                    
                    // All button
                    HStack {
                        
                        Button {
                            fAQ = true
                         contactUs = false
                            
                        } label: {
                            VStack {
                                Text("FAQ")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( fAQ ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                            Color("gray"),
                                            Color("gray"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                
                                ZStack {
                                    if fAQ {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.trailing, -9)
                                            .frame(height: 2)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            fAQ = false
                            contactUs = true
                            
                        } label: {
                            VStack {
                                Text("Contact us")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundStyle( contactUs ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                            Color("gray"),
                                            Color("gray"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                                ZStack {
                                    if contactUs {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .frame(height: 4)
                                    } else {
                                        Capsule()
                                            .fill((
                                                LinearGradient(colors: [
                                                    Color("grayOne"),
                                                    Color("grayOne"),
                                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ))
                                            .padding(.leading, -8)
//                                            .padding(.trailing, -40)
                                            .frame(height: 2)
                                    }
                                }
                            }
                        }
                        
                       
                        
                    }
                    
                    if fAQ {
                        
                       
                        
                    } else {
                        
                        VStack(spacing: 25) {
                            
                            HStack {
                                Image("CustomerServiceHC")
                                    .padding(.leading)
                                Text("Customer Service")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .padding(.leading, 6)
                                Spacer()
                            }
                            .frame(height: 72)
                            .background(.white)
                            .cornerRadius(20)
                            
                            .clipped()
                            .shadow(color: Color(#colorLiteral(red: 0.01258473936, green: 0.0208256077, blue: 0.07114783674, alpha: 0.05354925497)), radius: 5, x: 0, y: 4)
                            
                            HStack {
                                Image("WhatAppHC")
                                    .padding(.leading)
                                Text("WhatsApp")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .padding(.leading, 6)
                                Spacer()
                            }
                            .frame(height: 72)
                            .background(.white)
                            .cornerRadius(20)
                            
                            .clipped()
                            .shadow(color: Color(#colorLiteral(red: 0.01258473936, green: 0.0208256077, blue: 0.07114783674, alpha: 0.05354925497)), radius: 5, x: 0, y: 4)
                            
                            HStack {
                                Image("WebHC")
                                    .padding(.leading)
                                Text("Website")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .padding(.leading, 6)
                                Spacer()
                            }
                            .frame(height: 72)
                            .background(.white)
                            .cornerRadius(20)
                            
                            .clipped()
                            .shadow(color: Color(#colorLiteral(red: 0.01258473936, green: 0.0208256077, blue: 0.07114783674, alpha: 0.05354925497)), radius: 5, x: 0, y: 4)
                            
                            HStack {
                                Image("facebookHC")
                                    .padding(.leading)
                                Text("Facebook")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .padding(.leading, 6)
                                Spacer()
                            }
                            .frame(height: 72)
                            .background(.white)
                            .cornerRadius(20)
                            
                            .clipped()
                            .shadow(color: Color(#colorLiteral(red: 0.01258473936, green: 0.0208256077, blue: 0.07114783674, alpha: 0.05354925497)), radius: 5, x: 0, y: 4)
                            
                            HStack {
                                Image("TwitterHC")
                                    .padding(.leading)
                                Text("Twitter")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .padding(.leading, 6)
                                Spacer()
                            }
                            .frame(height: 72)
                            .background(.white)
                            .cornerRadius(20)
                            
                            .clipped()
                            .shadow(color: Color(#colorLiteral(red: 0.01258473936, green: 0.0208256077, blue: 0.07114783674, alpha: 0.05354925497)), radius: 5, x: 0, y: 4)
                            
                            HStack {
                                Image("InstagramHC")
                                    .padding(.leading)
                                Text("Instagram")
                                    .font(.custom("Urbanist-Bold", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .padding(.leading, 6)
                                Spacer()
                            }
                            .frame(height: 72)
                            .background(.white)
                            .cornerRadius(20)
                            
                            .clipped()
                            .shadow(color: Color(#colorLiteral(red: 0.01258473936, green: 0.0208256077, blue: 0.07114783674, alpha: 0.05354925497)), radius: 5, x: 0, y: 4)
                            
                        }
                        .padding(.top)
                        
                    }
                    
                   
                    
                    Spacer()
                }
                
                .padding(.horizontal)
            }
        }
    }
    
}

struct HelpCenterView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCenterView()
    }
}
