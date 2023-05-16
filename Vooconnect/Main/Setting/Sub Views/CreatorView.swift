//
//  CreatorView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct CreatorView: View {
    
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
                        
                        Text("Creator")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("PlusCreator")
                        }

                        
                    }
                    
                    VStack {
                        Text("Become a Creator and offer premium content to premium subscribers")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
                        Text("Create Monthly plans and choose what you share with your premium subscribers")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .font(.custom("Urbanist-Medium", size: 14))
                    .padding(.top)
                    
                    VStack {
                        Text("Premium Plan 1")
                        Image("squareTwoS")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        
                        Text("$5 / Month")
                        
                        HStack {
                            Image("WorkCreator")
                            Text("Subscribe")
                                .font(.custom("Urbanist-SemiBold", size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(width: 116, height: 26)
                        .background(Color(#colorLiteral(red: 1, green: 0.4038823843, blue: 0.4780470729, alpha: 1)))
                        .cornerRadius(15)
                        
                        VStack(alignment: .leading) {
                            
                            Text("1. you get access to premium live videos")
                            Text("2. premium reel videos")
                            Text("3. prioritized message reply")
                            
                        }
                        Button {
                            
                        } label: {
                            Text("show More")
                        }
                        
                        
                    }
                    
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
    }
}
