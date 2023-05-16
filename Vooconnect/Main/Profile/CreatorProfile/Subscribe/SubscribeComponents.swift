//
//  SubscribeComponents.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI

struct SubscribeHeaderView: View{
    var body: some View{
        VStack(spacing: 9){
            HStack(spacing: 4){
                Image("StarS")
                    .resizable()
                    .frame(width: 20, height: 19)
                Text("Creator")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                    .gradientForeground()
            }
            Text("Become a premium subscriber of")
                .font(.urbanist(name: .urbanistMedium, size: 10))
            Text("Jenny Wilson")
                .font(.urbanist(name: .urbanistBold, size: 18))
        }
    }
}

struct SubscriberPlanView: View{
    
    @State var lineLimit: Int? = 3
    var body: some View{
        VStack(spacing: 8){
            HStack{
                Spacer()
                Text("Premium Plan 1")
                    .font(.urbanist(name: .urbanistBold, size: 18))
                    .padding(.top, 17)
                Spacer()
            }
            Image("squareTwoS")
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            Text("$5 / Month")
                .font(.urbanist(name: .urbanistBold, size: 18))
                .gradientForeground()
            
            PrimaryFillButton(title: "Subscribe", icon: "WorkCreator", isIconExist: true, height: 26, cornerRadius: 13, gradient: Color.pinkGradient){ }
                .frame(width: 116)
            
            Text("1. You get access to premium live videos\n2. premium reel videos\n3. prioritized message reply\n4. e scene stuff")
                .lineLimit(lineLimit)
                .font(.urbanist(name: .urbanistMedium, size: 12))
            
            Button{
                withAnimation{
                    lineLimit == nil ? (lineLimit = 3) : (lineLimit = nil)
                }
            } label: {
                Text(lineLimit == nil ? "Show Less" : "See More")
                    .font(.urbanist(name: .urbanistMedium, size: 12))
                    .gradientForeground()
            }
            .padding(.bottom, 20)
            .frame(height: 30)
        }
        .overlay{
            Rectangle()
                .stroke(Color.purpleYellowGradient, lineWidth: 1)
        }
    }
}
