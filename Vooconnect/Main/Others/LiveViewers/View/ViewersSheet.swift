//
//  ViewersSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 23/12/22.
//

import SwiftUI

struct ViewersSheet: View {
    
    @State private var search: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("3.6K Viewers")
                .font(.custom("Urbanist-Bold", size: 24))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9017487583)))
                .padding(.top, 30)
         
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            
            CustomeTextFieldSix(text: $search, placeholder: "Search", iconLeading: "SearchS")
                .frame(height: 55)
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutLS, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<10) { people in
                            ViewersList()
                        }
                    }
                }
                
            }
            
        }
        .padding(.horizontal)
    }
}

struct ViewersSheet_Previews: PreviewProvider {
    static var previews: some View {
        ViewersSheet()
    }
}
