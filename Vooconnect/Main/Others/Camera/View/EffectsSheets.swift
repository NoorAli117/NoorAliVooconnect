//
//  EffectsSheets.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
//

import SwiftUI


struct EffectsSheets: View {
    @State private var trending: Bool = true
    @State private var new: Bool = false
    @ObservedObject var Vm: ViewModel
    @State private var selectedCategoryIndex = 0
    
    var body: some View {
        VStack {
            
            Text("Effects")
                .font(.custom("Urbanist-Bold", size: 24))
                .padding(.top, 30)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .opacity(0.2)
            // .padding(.vertical, 10)
                .padding(.bottom, 10)
            
            // All Button
            HStack {
                Image("cutF")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<Vm.categories.count, id: \.self) { index in
                            Button(action: {
                                selectedCategoryIndex = index
                            }) {
                                HStack {
                                    Text(Vm.categories[index].title!)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                            .onChange(of: selectedCategoryIndex) { newValue in
                                trending = true
                                new = false
                            }
                        }

                    }
                    .padding(.horizontal)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(Array(Vm.categories[selectedCategoryIndex].items.enumerated()), id: \.element.uuid) { index, item in
                        VStack {
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
                        .accessibility(addTraits: .isButton)
                        .onTapGesture {
                            Vm.selectFilter = true
                            Vm.selectedFilterIndex = index
                            Vm.selectedFiltersection = selectedCategoryIndex
                        }
                    }
                }
            }

            .padding(.top, 10)
            
        }
        .padding(.horizontal, 20)
    }
}


//struct EffectsSheets_Previews: PreviewProvider {
//    static var previews: some View {
//        EffectsSheets()
//    }
//}
