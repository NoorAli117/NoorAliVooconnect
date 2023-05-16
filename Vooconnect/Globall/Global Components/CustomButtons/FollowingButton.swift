//
//  FollowingButton.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI

struct FollowingButton: View {
    let action: (()->())
    var body: some View {
        Button {
            action()
        } label: {
            Spacer()
            Text("Following")
                .font(.urbanist(name: .urbanistMedium, size: 14))
                .foregroundStyle(Color.primaryGradient)
            Spacer()
        }
        .frame(height: 30)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(Color.primaryGradient, lineWidth: 2)
        }
    }
}
