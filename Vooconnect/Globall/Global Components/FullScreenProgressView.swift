//
//  FullScreenProgressView.swift
//  Vooconnect
//
//  Created by Online Developer on 31/03/2023.
//

import SwiftUI

struct FullScreenProgressView: View{
    var body: some View{
        VStack(spacing: 10){
            Spacer()
            
            ProgressView()
                .scaleEffect(2)
                .tint(.white)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        .background(.black.opacity(0.8))
    }
}
