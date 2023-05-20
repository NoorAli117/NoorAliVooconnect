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


//func setFilter(_ filter: Item) {
//    guard
//        let title = filter.title,
//        let thumbnailUrl = filter.thumbnail
//        else {
//            return
//    }
//
//    self.filterNameLabel.text = title
//    self.filterImage.sd_setImage(with: URL(string: thumbnailUrl), placeholderImage: nil, options: [.refreshCached], completed: nil)
//}

struct FiltersList: View {
    var filter: ItemData?
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: filter?.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                     .frame(width: 80, height: 80)
    //                .clipped()
                    .cornerRadius(24)
            } placeholder: {
                Image("FilterImageF")
                    .resizable()
                    .scaledToFill()
                     .frame(width: 80, height: 80)
    //                .clipped()
                    .cornerRadius(24)
            }
            Text(filter?.title ?? "B1")
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
