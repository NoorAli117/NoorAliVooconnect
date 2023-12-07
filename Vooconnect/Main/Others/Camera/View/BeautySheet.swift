//
//  EffectsSheets.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
//

import SwiftUI

struct BeautySheet: View {
    @StateObject var Vm = ViewModel()
    let iconNames = [
        "icVlineBlack",
        "icFacewidthBlack",
        "icFacelengthBlack",
        "icChinlengthBlack",
        "icEyesizeBlack",
        "icEyewidthBlack",
        "icNosenarrowBlack",
        "icAlaBlack",
        "icNoselengthBlack",
        "icMouthsizeBlack",
        "icEyebackBlack",
        "icEyeangleBlack",
        "icLipsBlack",
        "icSkinBlack",
        "icDarkcircleBlack",
        "icWrinkleBlack"
    ]
    
    @State private var selectedIndex: Int? = 0
    @State private var sliderValue: Double = 0.5
    @State private var sheetHeight: CGFloat = 150
    let kBeautyViewCompareIconName = "icCompareBlack"
    let kBeautyViewResetIconName = "icRefreshBlack"
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Slider(value: $Vm.sliderValue, in: 0...1)

                Button(action: {Vm.compareBeauty = true}){
                    Image(kBeautyViewCompareIconName)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button(action: {}){
                    Image(kBeautyViewResetIconName)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(iconNames.indices, id: \.self) { index in
                        BeautyCell(iconName: iconNames[index], selected: selectedIndex == index)
                            .onTapGesture {
                                if selectedIndex != index || Vm.beautyIndexPath.section != 1 {
                                    selectedIndex = index
                                    Vm.selectBeauty = true
                                    Vm.beautyIndex = index
                                    Vm.beautyIndexPath = IndexPath(row: index, section: 0)
                                    print(Vm.beautyIndexPath)
                                }
                            }
                    }
                }
            }
        }
        .onAppear {
            // Set up the sheetHeight if needed
        }
    }
}

struct BeautyCell: View {
    let iconName: String
    let selected: Bool
    let size: CGFloat = 50
    
    var body: some View {
        VStack {
            Image("\(iconName)\(selected ? "_en" : "Off_en")")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
    }
}


