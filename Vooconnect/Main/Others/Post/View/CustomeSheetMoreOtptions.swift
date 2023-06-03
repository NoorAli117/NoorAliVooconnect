//
//  CustomeSheetMoreOtptions.swift
//  Vooconnect
//
//  Created by Vooconnect on 08/12/22.
//

import SwiftUI

struct CustomeSheetMoreOtptions: View {
    
    @State private var saveToDeviceOn = false
    @State private var showLanguages = false
    @State private var autoCationOn = false
    @State private var selectedLanguage = "en-US"
    var saveToDevice : (Bool) -> () = {val in}
    var autoCation : (Bool) -> () = {val in}
    var captionLang: (String) -> () = {val in}
    
    var body: some View {
        VStack {
            Text("More options")
                .font(.custom("Urbanist-Bold", size: 24))
            
            VStack {
                
                HStack {
                    
                    Image("DownloadLogo")
                    
                    Text("Save to device")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                        .foregroundColor(.black)
                        .padding(.leading, 12)
                    
                    
                    Spacer()
                    
                    ZStack {
                        Capsule()
                            .frame(width:44,height:24)
                            .foregroundColor(.clear)
                            .background(saveToDeviceOn ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) :  LinearGradient(colors: [
                                            Color("grayOne"),
                                            Color("grayOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(16)
                        ZStack{
                            Circle()
                                .strokeBorder(Color("buttionGradientOne"), lineWidth: 2)
                                .frame(width:22, height:22)
                                .overlay(
                                    Circle()
                                        .fill(Color.white))
                        }
                        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
                        .offset(x:saveToDeviceOn ? 9.5 : -9.5)
                    }
                    .onTapGesture {
                        self.saveToDeviceOn.toggle()
                        self.saveToDevice(self.saveToDeviceOn)
                        
                    }

                    
                }
                
                
                HStack {
                    
                    Image("captionsPurple")
                    
                    Text("Allow auto-generated captions")
                        .font(.custom("Urbanist-SemiBold", size: 14))
                        .foregroundColor(.black)
                        .padding(.leading, 12)
                    
                    
                    Spacer()
                    
                    ZStack {
                        Capsule()
                            .frame(width:44,height:24)
                            .foregroundColor(.clear)
                            .background(autoCationOn ?
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing) :  LinearGradient(colors: [
                                            Color("grayOne"),
                                            Color("grayOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(16)
                        ZStack{
                            Circle()
                                .strokeBorder(Color("buttionGradientOne"), lineWidth: 2)
                                .frame(width:22, height:22)
                                .overlay(
                                    Circle()
                                        .fill(Color.white))
                        }
                        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
                        .offset(x:autoCationOn ? 9.5 : -9.5)
                    }
                    .onTapGesture {
                        self.autoCationOn.toggle()
                        self.autoCation(self.autoCationOn)
                    }

                    
                }
                
                
                HStack {
                    
                    Image("DownloadLogo")
                    
                    Button {
                        showLanguages.toggle()
                    } label: {
                        Text("select caption language")
                            .font(.custom("Urbanist-SemiBold", size: 14))
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 12)
                    
                    Spacer()
                    
                    Text(selectedLanguage)
                    
                    Image("ArrowLogo")
                    
                }
                
                
            }
            Spacer()
        }
        .padding(.horizontal)
        .sheet(isPresented: $showLanguages) {
            BotSheetView(selectedLang: selectedLanguage, onItemSelected: { lang in
                selectedLanguage = lang
                self.captionLang(lang)
                showLanguages.toggle()
                // Perform actions with the selected language, such as updating the model
                // For example: model.updateSelectedLanguage(lang)
            })
        }
//        Text("Selected Language: \(selectedLanguage)")
    }
}

struct CustomeSheetMoreOtptions_Previews: PreviewProvider {
    static var previews: some View {
        CustomeSheetMoreOtptions()
    }
}
