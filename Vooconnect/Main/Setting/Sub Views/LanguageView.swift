//
//  LanguageView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct LanguageView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var slectedLanguage: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
//                    NavigationLink(destination: FillYourProfileView()
//                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $birthDayVM.birthDayDataModel.navigate) {
//                            EmptyView()
//                        }
                    
                    // Back Button
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Language")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    
                    ScrollView {
                        
                        HStack {
                            Text("Suggested")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            Spacer()
                        }
                        .padding(.top, 8)
                        
                        VStack(spacing: 30) {
                            
                            HStack {
                                
                                Text("English (US)")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("English (UK)")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            
                        }
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        .padding(.top)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray)
                            .opacity(0.2)
                            .padding(.vertical, 8)
                        
                        HStack {
                            Text("Language")
                                .font(.custom("Urbanist-Bold", size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            Spacer()
                        }
                        
                        VStack(spacing: 30) {
                            
                            HStack {
                                
                                Text("Mandarin")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("Hindi")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("Spanish")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("French")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("Arabic")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("Bengali")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("Russian")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                            HStack {
                                
                                Text("Indonesia")
                                
                                Spacer()
                                
                                Button {
                                    slectedLanguage.toggle()
                                } label: {
                                    Image(slectedLanguage ? "SlectedLanguage" : "UnSlectedLanguage")
                                }
                            }
                            
                        }
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        .padding(.top)
                        
                    }
                    
//                    Spacer()
                }
                .padding(.horizontal)
                
            }
        }
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView()
    }
}
