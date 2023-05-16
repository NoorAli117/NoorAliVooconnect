//
//  NotificationCellTwo.swift
//  Vooconnect
//
//  Created by Vooconnect on 06/01/23.
//

import SwiftUI

struct NotificationCellTwo: View {
    var body: some View {
        HStack {
            
            Image("squareTwoS")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Charolette Hanlin")
                    .font(.custom("Urbanist-Bold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                Text("Leave a comment on your video")
                    .font(.custom("Urbanist-Medium", size: 14))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))

            }
            .padding(.leading, 10)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Follow Back")
                    .font(.custom("Urbanist-SemiBold", size: 14))
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(
                        LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(30)
            }

        }
    }
}

struct NotificationCellTwo_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCellTwo()
    }
}
