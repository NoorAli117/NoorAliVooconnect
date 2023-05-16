//
//  LiveSettingsSheet.swift
//  Vooconnect
//
//  Created by Vooconnect on 21/12/22.
//

import SwiftUI

struct LiveSettingsSheet: View {
    
    @State private var liveGifts: Bool = false
    @State private var commentAllow: Bool = true
    @State private var filterWords: Bool = false
    
    @State var text = ""
    @State var didStartEditing = false
    
    @State var placeholder: String = ""
    
    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
            case captionn
        }
    
    @State private var moderatorsView: Bool = true
    @State private var addModeratorsView: Bool = true
    
    var body: some View {
        
        if moderatorsView == true {
            
            VStack {
                
                //            NavigationLink(destination: ModeratorsView()
                //                .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $moderatorsView) {
                //                    EmptyView()
                //                }
                
                Text("Settings")
                    .font(.custom("Urbanist-Bold", size: 24))
                    .padding(.top)
                
                HStack {
                    
                    Text("Moderators")
                        .font(.custom("Urbanist-Bold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                    
                    Spacer()
                    
                    Button {
                        moderatorsView = false
                        addModeratorsView = true
                    } label: {
                        Image("ArrowLogo")
                            .frame(width: 25, height: 25)
                    }
                    
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text("Live Gifts")
                            .font(.custom("Urbanist-SemiBold", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                        
                        Text("Allow viewer to send gift during your LIVE")
                            .font(.custom("Urbanist-Regular", size: 12))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                    }
                    
                    Spacer()
                    
                    Button {
                        liveGifts.toggle()
                        
                    } label: {
                        Image(liveGifts ? "RadioLS" : "EllipseLS")
                    }
                    
                }
                .padding(.top, 8)
                
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text("Comments")
                            .font(.custom("Urbanist-SemiBold", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                        
                        Text("Send and receive comments during your LIVE")
                            .font(.custom("Urbanist-Regular", size: 12))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                    }
                    
                    Spacer()
                    
                    Button {
                        commentAllow.toggle()
                        
                    } label: {
                        Image(commentAllow ? "RadioLS" : "EllipseLS")
                    }
                    
                }
                .padding(.top, 4)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Keyword Filter (3/200)")
                            .font(.custom("Urbanist-SemiBold", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                        Text("Hide comments that contain the keywords from your list")
                            .font(.custom("Urbanist-Regular", size: 12))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                    }
                    
                    Spacer()
                    
                    Button {
                        filterWords.toggle()
                    } label: {
                        Image("PlusLS")
                    }
                    
                }
                .padding(.top, 4)
                
                if filterWords {
                    VStack {
                        
                        HStack {
                            Image("TrangleLogo")
                                .frame(width: 44, height: 27)
                            Spacer()
                            
                        }
                        .padding(.leading, 30)
                        .padding(.vertical, -10)
                        VStack {
                            TextViewTwo(text: $text, didStartEditing: $didStartEditing, placeholder: $placeholder)
                                .focused($focusedField, equals: .captionn)
                                .onTapGesture {
                                    didStartEditing = true
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                                .frame(height: 105)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .strokeBorder((LinearGradient(colors: [
//                                            Color("GradientOne"),
//                                            Color("GradientTwo"),
//                                        ], startPoint: .top, endPoint: .bottom)
//                                        ), lineWidth: 2)
//                                }
                            
                            HStack {
                                Button {
                                    filterWords.toggle()
                                } label: {
                                    Text("Cancel")
                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal)
                                        .background(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .cornerRadius(30)
                                        .padding()
                                }
                                
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    Text("Save")
                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal)
                                        .background(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .cornerRadius(30)
                                        .padding()
                                }
                            }
                            
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder((LinearGradient(colors: [
                                    Color("GradientOne"),
                                    Color("GradientTwo"),
                                ], startPoint: .top, endPoint: .bottom)
                                ), lineWidth: 2)
                        }
                        
                    }
                    .padding(.top, 5)
                    
                }
                
                Spacer()
            }
            .onTapGesture {
                focusedField = nil
            }
            .padding(.horizontal)
        } else if addModeratorsView == true {
            ModeratorsView(back: $moderatorsView, addModerators: $addModeratorsView)
        } else {
            AddModeratorsListView(back: $addModeratorsView)
        }
        
    }
}

struct LiveSettingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        LiveSettingsSheet()
    }
}
