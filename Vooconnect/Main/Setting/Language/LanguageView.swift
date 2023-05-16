//
//  LanguageView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct LanguageView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @StateObject var viewModel = LanguageViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 10) {
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Image("BackButton")
                }
                
                Text("Language")
                    .font(.urbanist(name: .urbanistBold, size: 24))
                Spacer()
            }
            .frame(height: 30)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 40){
                    LanguageSectionTitle(title: "Suggested")
                    
                    ForEach(Language.suggestedCases, id:\.self){ language in
                        LanguageRowView(language: language){
                            withAnimation {
                                viewModel.selectedLanguage = language
                            }
                        }
                    }
                    
                    LanguageSectionTitle(title: "Language")
                    
                    ForEach(Language.otherLanguagesCases, id:\.self){ language in
                        LanguageRowView(language: language){
                            withAnimation {
                                viewModel.selectedLanguage = language
                            }
                        }
                    }
                }
                .padding(.top, 33)
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
}

extension LanguageView{
    func LanguageSectionTitle(title: String) -> some View{
        HStack{
            Text(title)
                .font(.urbanist(name: .urbanistBold, size: 20))
            
            Spacer()
        }
    }
    
    func LanguageRowView(language: Language, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            HStack{
                Text(language.rawValue)
                    .foregroundColor(.black)
                    .font(.urbanist(name: .urbanistSemiBold, size: 18))
                
                Spacer()
                
                Image( viewModel.selectedLanguage == language ? "SlectedLanguage" : "UnSlectedLanguage")
            }
        }
    }
}
