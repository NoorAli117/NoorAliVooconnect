//
//  BeautyView.swift
//  Vooconnect
//
//  Created by Mac on 11/06/2023.
//

import SwiftUI
import ARGear

struct BeautyView: View {
    
    let iconNames = [
        "icVline",
        "icFacewidth",
        "icFacelength",
        "icChinlength",
        "icEyesize",
        "icEyewidth",
        "icNosenarrow",
        "icAla",
        "icNoselength",
        "icMouthsize",
        "icEyeback",
        "icEyeangle",
        "icLips",
        "icSkin",
        "icDarkcircle",
        "icWrinkle"
    ]
    @State var selectedIndex = 0
    @State private var value: Float = 0
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack {
            HStack{
                Slider(value: $value)
                Image("icCompareBlack").resizable().frame(width: 40, height: 40)
                Image("icCompareBlack").resizable().frame(width: 40, height: 40)
                
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(iconNames.enumerated()), id: \.offset) { (index,item) in
                        Image(getIconName(index: index, withLanguageCode: true)).resizable().frame(width: 40,height: 40, alignment: .center).padding(.all, 10)
                            .onTapGesture {
                                selectedIndex = index
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedIndex == index ? Color.black : Color.clear, lineWidth: 2)
                            )
                    }
                }.frame(height: 50)
            }
        }.padding(.horizontal, 20).onAppear {
            open()
        }
    }
    func open() {
        let beautyIndex = 0
        
        self.value = BeautyManager.shared.getBeautyValue(type: ARGContentItemBeauty(rawValue: beautyIndex)!)
        BulgeManager.shared.off()
        ContentManager.shared.clearContent()
    }
    func getIconName(index: Int, withLanguageCode: Bool) -> String {
        var iconName = iconNames[index]
        if (ARGMediaRatio._16x9.rawValue != 0) {
            iconName.append("White")
        } else {
            iconName.append("Black")
        }
        if index != selectedIndex {
            iconName.append("Off")
        }
        else {
            iconName.append("Off")
        }
        if withLanguageCode {
            iconName.append("_".appendLanguageCode())
        }
        return iconName;
    }
    
}

struct BeautyView_Previews: PreviewProvider {
    static var previews: some View {
        BeautyView()
    }
}

