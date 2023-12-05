//
//  FiltersView.swift
//  Vooconnect
//
//  Created by Vooconnect on 15/12/22.
//

import SwiftUI
import UIKit

struct FiltersSheet: View {
    @State private var trending: Bool = true
    @State private var new: Bool = false
    @ObservedObject var Vm: ViewModel
    @State private var selectedCategoryIndex = 0
    @State private var sheetHeight: CGFloat = 150
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        Vm.clearFilter = true
                        selectedCategoryIndex = 0
                    }) {
                        HStack {
                            Image("cutF")
                                .resizable()
                                .foregroundColor(Color.gray)
                        }
                        .frame(width: 24, height: 24)
                    }
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
                }
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width < -100 {
                                if selectedCategoryIndex > 0 {
                                    selectedCategoryIndex -= 1
                                }
                            }
                        }
                )
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 16) {
                        ForEach(Array(Vm.categories[selectedCategoryIndex].items.enumerated()), id: \.element.uuid) { index, item in
                            ZStack {
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
                                .frame(width: 50, height: 50)
                                .accessibility(addTraits: .isButton)
                                .onTapGesture {
                                    Vm.filter = item
                                    Vm.selectFilter = true
                                    Vm.selectedFilterIndex = IndexPath(row: index, section: selectedCategoryIndex)
                                }
                                if Vm.selectedFilterIndex == IndexPath(row: index, section: selectedCategoryIndex) {
                                    Image("icCheckFilter")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                            }
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .padding(.horizontal, 20)
            .frame(height: sheetHeight)
            .onAppear {
                sheetHeight = UIScreen.main.bounds.height * 0.8
            }
        }
    }
}
        
//        struct FiltersSheet_Previews: PreviewProvider {
//            static var previews: some View {
//                FiltersSheet(cameraModel: CameraViewModel())
//            }
//        }
