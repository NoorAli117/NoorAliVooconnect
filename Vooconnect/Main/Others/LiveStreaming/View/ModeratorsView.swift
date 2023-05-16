//
//  ModeratorsView.swift
//  Vooconnect
//
//  Created by Vooconnect on 22/12/22.
// ArrowLS ArrowTwoLS

import SwiftUI

struct ModeratorsView: View {
    
    @State private var moderatorsList: Bool = false
    @State private var search: String = ""
    @Binding var back: Bool
    @Binding var addModerators: Bool
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button {
                    back.toggle()
                } label: {
                    Image("ArrowLS")
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Text("Moderators")
                    .font(.custom("Urbanist-SemiBold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                
                Spacer()

                Button {
//                    moderatorsList.toggle()
                    addModerators.toggle()
                } label: {
                    Image("ArrowTwoLS")
                        .frame(width: 24, height: 24)
                }
                
            }
            .padding(.top, 20)
//            .padding(.bottom)
            
//            if moderatorsList {
//                CustomeTextFieldSix(text: $search, placeholder: "Search", iconLeading: "SearchS")
//                    .frame(height: 55)
//            }
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutLS, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<4) { people in
                            ModeratorsListView()
                        }
                    }
                }
                
            }
            .padding(.top, 10)
            
        }
        .padding(.horizontal, 30)
        
    }
}

struct ModeratorsView_Previews: PreviewProvider {
    static var previews: some View {
        ModeratorsView(back: .constant(false), addModerators: .constant(false))
    }
}
