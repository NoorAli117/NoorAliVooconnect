//
//  SendtoJoinLiveSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 21/12/22.
//

import SwiftUI

struct SendtoJoinLiveSheet: View {
    
    var body: some View {
        
        VStack {
            
            Text("Share With")
                .font(.custom("Urbanist-Bold", size: 24))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                .padding(.top, 40)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
                .padding(.top, 6)
            
            HStack(spacing: 20) {
                
                VStack {
                    
                    Image("squareTwoS")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("Premium")
                        .font(.custom("Urbanist-Bold", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    Text("Plan 1")
                        .font(.custom("Urbanist-Bold", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    Text("Followers")
                        .font(.custom("Urbanist-Bold", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
                VStack {
                    
                    Image("squareTwoS")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("Premium")
                        .font(.custom("Urbanist-Bold", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    Text("Plan 1")
                        .font(.custom("Urbanist-Bold", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                    Text("Followers")
                        .font(.custom("Urbanist-Bold", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                }
                
            }
            .padding(.top)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
                .padding(.top, 10)
            
            
            HStack(spacing: 12) {
                
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
                
            }
            .padding(.top)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
                .padding(.top, 10)
            
            HStack(spacing: 12) {
                
                VStack {
                    
                    Image("YahooLV")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                    
                    Text("Link")
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
            .padding(.top)
            
            Spacer()
            
        }
    }
}

struct SendtoJoinLiveSheet_Previews: PreviewProvider {
    static var previews: some View {
        SendtoJoinLiveSheet()
    }
}
