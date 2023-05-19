//
//  FiltersList.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
//

import SwiftUI

let columnSpacingCF: CGFloat = 10  // ___
let rowSpacingCF: CGFloat = 0  // |||  20
var gridLayoutCF: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacingCF), count: 4)
}

struct FiltersList: View {
    var filterimage : String = "FilterImageF"
    var filterName : String = "Filter_1"
    var body: some View {
        VStack {
            Image(filterimage)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
//                .clipped()
                .cornerRadius(24)
            Text(filterName)
                .font(.custom("Urbanist-SemiBold", size: 18))
                .padding(.top, -3)
        }
    }
}

struct FiltersList_Previews: PreviewProvider {
    static var previews: some View {
//        FiltersList()
        FiltersList()
    }
}
