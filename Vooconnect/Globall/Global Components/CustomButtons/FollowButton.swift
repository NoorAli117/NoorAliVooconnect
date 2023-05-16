//
//  FollowButton.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI

struct FollowButton: View {
    let action: (()->())
    var body: some View {
        Button {
            action()
        } label: {
            Text("Follow")
                .font(.urbanist(name: .urbanistMedium, size: 14))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 17)
                .customGradient()
                .cornerRadius(16)
        }
    }
}
