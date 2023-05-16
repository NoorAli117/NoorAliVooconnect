//
//  SearchHashtagView.swift
//  Vooconnect
//
//  Created by Vooconnect on 13/12/22.
//

import SwiftUI

struct SearchHashtagView: View {
    var body: some View {
        HStack {
            Image("HastagS")
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            Text("ariana")
                .font(.custom("Urbanist-Bold", size: 18))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.8975838162)))
            Spacer()
            Text("99.36M")
                .font(.custom("Urbanist-SemiBold", size: 14))
                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.6994774421)))
        }
    }
}

struct SearchHashtagView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHashtagView()
    }
}
