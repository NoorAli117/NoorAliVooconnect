//
//  BottomSheetView.swift
//  Vooconnect
//
//  Created by Farooq Haroon on 6/2/23.
//

import SwiftUI

struct BotSheetView: View {
    @ObservedObject var viewModel = LangViewModel()
        @State var selectedLang = "en-US"
        var onItemSelected: ((String) -> Void)?

        var body: some View {
            List(viewModel.languages, id: \.key) { language in
                VStack(alignment: .leading) {
                    Button(language.name){
                        selectedLang = language.key
                        onItemSelected?(selectedLang)
                    }
                    .buttonStyle(CustomButtonStyle(isSelected: selectedLang == language.key))
                    .foregroundColor(.black)
                }
            }
//            .onAppear {
//                viewModel.fetchItems()
//            }
        }
}

struct CustomButtonStyle : ButtonStyle {
    var isSelected: Bool
 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
//            .foregroundColor(.black)
            .padding(8)
            .padding(.top,5)
            .foregroundColor(isSelected ? Color("buttionGradientTwo") : .black)
            //Could also modify style based on isSelected
    }
}
