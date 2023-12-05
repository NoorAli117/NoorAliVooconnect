//
//  EffectsSheets.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
//

import SwiftUI


struct BeautySheet: View {
    
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
    
    @State private var selectedIndex: Int?
    
    var body: some View {
        List(0..<iconNames.count, id: \.self) { index in
            BeautyCell(iconName: iconNames[index], selected: selectedIndex == index)
                .onTapGesture {
                    selectedIndex = index
                    print(index)
                }
        }
    }
}

struct BeautyCell: View {
    
    let iconName: String
    let selected: Bool
    
    var body: some View {
        HStack {
            Image(iconName)
            Text(iconName)
        }
        .foregroundColor(selected ? .blue : .black)
    }
}
