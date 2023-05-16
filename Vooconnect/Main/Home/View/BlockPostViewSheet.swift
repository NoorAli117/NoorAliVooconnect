//
//  BlockPostViewSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 17/12/22.
//

import SwiftUI

struct BlockPostViewSheet: View {
    
    @Binding var massage: String
    @Binding var dismis: Bool
    @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(massage)
            Button {
                
                    likeVM.blockPostApi()
//                    likeVM.blockPostDataModel.isPresentingSuccess = true
                
                dismis.toggle()
            } label: {
                Text("Yes")
                    .frame(width: 100)
                    .font(.custom("Urbanist-Bold", size: 16))
                    .foregroundColor(.white)
                    .padding()
            }
            .background(
                LinearGradient(colors: [
                    Color("buttionGradientTwo"),
                    Color("buttionGradientOne"),
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(40)
            
            
            Button {
                dismis.toggle()
            } label: {
                Text("No")
                    .frame(width: 100)
                    .font(.custom("Urbanist-Bold", size: 16))
                    .foregroundStyle(
                        LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding()
            }
            .background(Color("SkipButtonBackground"))
            .cornerRadius(40)
            
            Spacer()
            
        }

    }

}

struct BlockPostViewSheet_Previews: PreviewProvider {
    static var previews: some View {
        BlockPostViewSheet(massage: .constant(""), dismis: .constant(false))
    }
}
