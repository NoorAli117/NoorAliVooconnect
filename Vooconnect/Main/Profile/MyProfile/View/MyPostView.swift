//
//  MyPostView.swift
//  Vooconnect
//
//  Created by Vooconnect on 19/12/22.
//

import SwiftUI

let columnSpacingMP: CGFloat = 10  // ___
let rowSpacingMP: CGFloat = 8  // |||  20  8  .flexible()
var gridLayoutMP: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingMP), count: 3)
}

struct MyPostView: View {
    var body: some View {
        Image("ReelsImage")  // ImageMP
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipped()
            .cornerRadius(12)
    }
}

struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView()
//        MyProfileView()
    }
}
