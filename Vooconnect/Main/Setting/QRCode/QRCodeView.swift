//
//  QRCodeView.swift
//  Vooconnect
//
//  Created by Zeeshan Suleman on 22/04/2023.
//

import SwiftUI

struct QRCodeView: View {
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.purpleYellowGradient)
                .ignoresSafeArea()
            
            VStack{
                HStack(spacing: 16) {
                    Button {
                        presentaionMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackButton")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    
                    Text("QR Code")
                        .font(.urbanist(name: .urbanistBold, size: 24))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image("ShareS")
                }
                .frame(height: 30)
                
                VStack(spacing: 0){
                    ProfileImageView()
                    
                    Image("QrCodeImageS")
                        .padding(.top, 12)
                    
                    Text("@andrew_ainsley")
                        .foregroundColor(.white)
                        .font(.urbanist(name: .urbanistBold, size: 24))
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    PrimaryFillButton(
                        title: "Scan QR Code",
                        icon: "ScanSettings",
                        isIconExist: true,
                        height: 58,
                        cornerRadius: 29,
                        backgroundOpacity: 0.08,
                        titleColor: .white,
                        renderMode: .template){
                            
                        }
                        .foregroundColor(.white)
                }
                .padding(.top, 95)
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .navigationBarHidden(true)
        }
    }
}

extension QRCodeView{
    func ProfileImageView() -> some View{
        Image("profileicon")
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
            .clipped()
            .cornerRadius(10)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purpleYellowGradient,lineWidth: 10)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white,lineWidth: 6)
                }
            )
    }
}
