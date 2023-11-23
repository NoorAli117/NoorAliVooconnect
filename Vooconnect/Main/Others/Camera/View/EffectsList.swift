//
//  EffectsList.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
// EffectsImageE

import SwiftUI

struct EffectsList: View {
    @ObservedObject var Vm: ViewModel
    @State private var selectedCategoryIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Categories", selection: $selectedCategoryIndex) {
                    ForEach(0..<Vm.categories.count, id: \.self) { index in
                        Text(Vm.categories[index].title!)
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle.init())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Vm.categories[selectedCategoryIndex].items, id: \.uuid) { item in
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: item.thumbnail ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image("EffectsImageE")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                            }
                            .frame(width: 150)
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

//
//struct EffectsList_Previews: PreviewProvider {
//    static var previews: some View {
//        EffectsList()
//    }
//}
