//
//  SendSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 26/12/22.
//

import SwiftUI

struct SendSheet: View {
    
    var body: some View {
        
        VStack {
            
            Text("Share With")
                .font(.custom("Urbanist-Bold", size: 24))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                .padding(.top, 30)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
                .padding(.bottom, 10)
            
            
            HStack(spacing: 20) {
                
                VStack {
                    
                    Image("squareTwoS")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("andrew...")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                .padding(.leading, 20)
                
                VStack {
                    
                    Image("squareTwoS")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("andrew...")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("squareTwoS")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("andrew...")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("AutoLS")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                    
                    Text("Search")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    
                }
                
                
                Spacer()
                
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            
                .padding(.vertical, 10)
            
            HStack(spacing: 15) {
                
                VStack {
                    
                    Image("YahooLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("Yahoo")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("WhatAppLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("WhatsApp")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("MassageLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("SMS")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("FaceBookLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                    
                    Text("Facebook")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    
                }
                
                VStack {
                    
                    Image("MailLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                    
                    Text("Email")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    
                }
                
                
                
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            
                .padding(.vertical, 10)
            
            HStack(spacing: 35) {
                
                VStack {
                    
                    Image("ReportLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("Report")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("FeedbackLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("Feedback")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("BackgroundPlayerLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("Background \n Player")
                        .multilineTextAlignment(.center)
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                .offset(y: 7)
                
                VStack {
                    
                    Image("SettingLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                    
                    Text("Settings")
                        .font(.custom("Urbanist-Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    
                }
                
                
            }
            .padding(.top, -5)
            
            Spacer()
            
        }
        .padding(.horizontal)
        
    }
}

struct SendSheet_Previews: PreviewProvider {
    static var previews: some View {
        SendSheet()
    }
}
