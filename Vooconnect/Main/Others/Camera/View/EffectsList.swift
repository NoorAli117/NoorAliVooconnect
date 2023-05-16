//
//  EffectsList.swift
//  Vooconnect
//
//  Created by Vooconnect on 31/12/22.
// EffectsImageE

import SwiftUI

struct EffectsList: View {
    var body: some View {
        VStack {
            Image("EffectsImageE")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
//                .clipped()
                .cornerRadius(24)
            Text("Effect 1")
                .font(.custom("Urbanist-SemiBold", size: 18))
                .padding(.top, -3)
        }
    }
}

struct EffectsList_Previews: PreviewProvider {
    static var previews: some View {
        EffectsList()
    }
}
