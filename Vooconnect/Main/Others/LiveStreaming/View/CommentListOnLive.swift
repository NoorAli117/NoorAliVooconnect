//
//  CommentListOnLive.swift
//  Vooconnect
//
//  Created by Vooconnect on 22/12/22.
//

import SwiftUI

let columnSpacingCommentLS: CGFloat = 10  // ___
let rowSpacingCommentLS: CGFloat = 8  // |||  20
var gridLayoutCommentLS: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingCommentLS), count: 1)
}
struct CommentListOnLive: View {
    
    @Binding var creatorDetaiSheet: Bool
    
    var body: some View {
        HStack {
            Button {
                creatorDetaiSheet.toggle()
            } label: {
                Image("squareTwoS")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text("Daryl Nehls")
                    .font(.custom("Urbanist-Bold", size: 14))
                    .foregroundColor(.white)
                 Text("How are you?")
                    .font(.custom("Urbanist-Medium", size: 12))
                    .foregroundColor(.white)
            }
            .padding(.leading, 0)
            
            Spacer()
        }
    }
}

struct CommentListOnLive_Previews: PreviewProvider {
    static var previews: some View {
        CommentListOnLive(creatorDetaiSheet: .constant(false))
    }
}
