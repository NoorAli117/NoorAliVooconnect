//
//  QuestionAnswerList.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct QuestionAnswerList: View {
    
    @State private var commentText: String = ""
    @State private var commentReplay: Bool = false
    @State private var commentLike: Bool = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Image("squareTwoS")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Benny Spanbauer")
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.697459644)))
                    
                    Text("What is your favorite fruit? ")
                        .font(.custom("Urbanist-SemiBold", size: 16))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9009985513)))

                    HStack {
                        
                    Text("Reply")
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.697459644)))
                        
                        Button {
                            commentReplay.toggle()
                        } label: {
                            Image("ArrowDownLogoM")
                                .frame(height: 16)
                        }

                        
                        
                    }

                    
                }
                .padding(.leading, 6)
                
                Spacer()
                
                VStack {
                    
                    Button {
                        commentLike.toggle()
                    } label: {
                        Image(commentLike ? "HeartRedLV" : "HeartLV") // HeartRedLV
                    }
                    
                    Text("736")
                        .font(.custom("Urbanist-Medium", size: 12))
//                        .foregroundColor(Color())
                    
                }
                
            }
            
            if commentReplay {
                
                CustomeCommentTextField(text: $commentText, placeholder: "Type your reply here")
                    .font(.custom("Urbanist-Regular", size: 14))
                    .padding(.top, 4)
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundStyle(LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                      ], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                    .padding(.top, -4)
                
                HStack {
                    
                    Button {
                        
                    } label: {
                        Image("smileLV")
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("cancel") // Bold
                            .font(.custom("Urbanist-Bold", size: 14))
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 8)

                    Button {
                        
                    } label: {
                        Text("Send")
                            .font(.custom("Urbanist-SemiBold", size: 14))
                            .foregroundColor(.white)
                    }
                    
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                      ], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(20)

                }
                .padding(.top, -3)
                
            }
            
        }
        .padding(.horizontal)
        
    }
}

struct QuestionAnswerList_Previews: PreviewProvider {
    static var previews: some View {
        QuestionAnswerList()
    }
}
