//
//  SecurityView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct SecurityView: View {
    
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
                    
                    // Back Button
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Security")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Control")
                            .font(.custom("Urbanist-Bold", size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        Spacer()
                    }
                    .padding(.top)
                    
                    VStack(spacing: 20) {
                        
                        HStack {
                            Text("Security Alerts")
                            Spacer()
                            Image("ArrowLogo")
                        }
                        
                        HStack {
                            Text("Manage Devices")
                            Spacer()
                            Image("ArrowLogo")
                        }
                        
                    }
                    .font(.custom("Urbanist-SemiBold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                    .padding(.top, 5)
                    
                    HStack {
                        Text("Security")
                            .font(.custom("Urbanist-Bold", size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        Spacer()
                    }
                    .padding(.top, 8)
                    
                    VStack(spacing: 20) {
                        
                        HStack {
                            Text("Remember me")
                            Spacer()
                            Image("ArrowLogo")
                        }
                        
                        HStack {
                            Text("Face ID")
                            Spacer()
                            Image("ArrowLogo")
                        }
                        
                        HStack {
                            Text("Biometric ID")
                            Spacer()
                            Image("ArrowLogo")
                        }
                        
                    }
                    .font(.custom("Urbanist-SemiBold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                    .padding(.top, 5)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Change PIN")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 0.4838140607, green: 0.3263685703, blue: 0.754865706, alpha: 1)))
                            Spacer()
                        }
                    }
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.5921568627, green: 0.3098039216, blue: 1, alpha: 0.09827711093)))
                    .cornerRadius(30)
                    .padding(.top, 10)
                    

                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Change Password")
                                .font(.custom("Urbanist-Bold", size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 0.4838140607, green: 0.3263685703, blue: 0.754865706, alpha: 1)))
                            Spacer()
                        }
                    }
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.5921568627, green: 0.3098039216, blue: 1, alpha: 0.09827711093)))
                    .cornerRadius(30)
                    .padding(.top)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
            }
        }
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
