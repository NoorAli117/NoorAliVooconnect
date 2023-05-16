//
//  QuestionAnswerSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct QuestionAnswerSheet: View {
    
    @State private var commentText: String = ""
    @State private var textFieldColor: Bool = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Question & Answer")
                .font(.custom("Urbanist-Bold", size: 24))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                .padding(.top, 30)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            
            HStack {
                Text("3,378 questions from guests")
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutLS, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<10) { people in
                            QuestionAnswerList()
                        }
                    }
                }
                
            }
            
            HStack {
                                
                CustomeTextFieldThree(text: $commentText, placeholder: "Ask a question...", color: $textFieldColor, icon: "smileGrayLV")
                                
                Button {
                    
                } label: {
                    Image("SendTwoLV")
                }

                
                
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct QuestionAnswerSheet_Previews: PreviewProvider {
    static var previews: some View {
        QuestionAnswerSheet()
    }
}
