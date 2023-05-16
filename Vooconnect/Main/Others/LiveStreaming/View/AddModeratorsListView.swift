//
//  AddModeratorsListView.swift
//  Vooconnect
//
//  Created by Vooconnect on 22/12/22.
//

import SwiftUI

struct AddModeratorsListView: View {
    
    @State private var search: String = ""
    @Binding var back: Bool
    
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
                
                Text("Add Moderators")
                    .font(.custom("Urbanist-SemiBold", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                
                Spacer()
                
            }
            .padding(.top, 20)
            
            CustomeTextFieldSix(text: $search, placeholder: "Search", iconLeading: "SearchS")
                                .frame(height: 55)
                                .padding(.top)
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: gridLayoutLS, alignment: .center, spacing: columnSpacingLS, pinnedViews: []) {
                    Section()
                    {
                        ForEach(0..<4) { people in
                            AddModeratorsList()
                        }
                    }
                }
                
            }
            .padding(.top, 10)
            
        }
        .padding(.horizontal, 30)
    }
}

struct AddModeratorsListView_Previews: PreviewProvider {
    static var previews: some View {
        AddModeratorsListView(back: .constant(false))
    }
}
