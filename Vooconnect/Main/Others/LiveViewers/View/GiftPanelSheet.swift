//
//  GiftPanelSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 26/12/22.
//

import SwiftUI

struct GiftPanelSheet: View {
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("Gift Shop")
                    .font(.custom("Urbanist-Bold", size: 24))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                
                Spacer()
                
                Button {
                
                } label: {
                    Image("RechargeButtonLV")
                }

            }
            .padding(.top, 30)
            
//            Rectangle()
//                .frame(height: 1)
//                .foregroundColor(Color.gray)
//                .opacity(0.2)
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutGP, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<15) { people in
                            GiftPanelList()
                        }
                        
                    }
                }
                
            }
            
            
//            Spacer()
        }
        .padding(.horizontal)
    }
}

struct GiftPanelSheet_Previews: PreviewProvider {
    static var previews: some View {
        GiftPanelSheet()
    }
}
