//
//  SearchButtonView.swift
//  Vooconnect
//
//  Created by Vooconnect on 13/12/22.
//

import SwiftUI

struct SearchButtonView: View {
    
    @Binding var all: Bool
    @Binding var people: Bool
    @Binding var videos: Bool
    @Binding var sounds: Bool
    @Binding var live: Bool
    @Binding var hashtag: Bool
    @Binding var top: Bool
    
    var body: some View {
        VStack {
            
            ZStack {
                
                // All Button
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.gray)
                    .opacity(0.2)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        
                        
                        HStack(spacing: 20) {
                            
                            VStack {
                                Button {
                                    
                                    all = true
                                    people = false
                                    videos = false
                                    sounds = false
                                    live = false
                                    hashtag = false
                                    top = false
                                    
                                } label: {
                                    Text("All")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundStyle( all ?
                                                          LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                            Color("gray"),
                                                            Color("gray"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                }
                                if all {
                                    Capsule()
                                        .fill(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .frame(width: 38, height: 4)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 38, height: 2)
                                }
                                
                            }
                            
                            VStack {
                                Button {
                                    all = false
                                    people = true
                                    videos = false
                                    sounds = false
                                    live = false
                                    hashtag = false
                                    top = false
                                    
                                } label: {
                                    Text("People")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundStyle( people ?
                                                          LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                            Color("gray"),
                                                            Color("gray"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                }
                                if people {
                                    Capsule()
                                        .fill(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .frame(width: 70, height: 4)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 0, height: 4)
                                }
                                
                            }
                            
                            VStack {
                                Button {
                                    all = false
                                    people = false
                                    videos = true
                                    sounds = false
                                    live = false
                                    hashtag = false
                                    top = false
                                    
                                } label: {
                                    Text("Videos")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundStyle( videos ?
                                                          LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                            Color("gray"),
                                                            Color("gray"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                }
                                if videos {
                                    Capsule()
                                        .fill(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .frame(width: 70, height: 4)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 0, height: 4)
                                }
                                
                            }
                            
                            VStack {
                                Button {
                                    all = false
                                    people = false
                                    videos = false
                                    sounds = true
                                    live = false
                                    hashtag = false
                                    top = false
                                    
                                } label: {
                                    Text("Sounds")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundStyle( sounds ?
                                                          LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                            Color("gray"),
                                                            Color("gray"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                }
                                if sounds {
                                    Capsule()
                                        .fill(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .frame(width: 70, height: 4)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 0, height: 4)
                                }
                                
                            }
                            
                            VStack {
                                Button {
                                    all = false
                                    people = false
                                    videos = false
                                    sounds = false
                                    live = true
                                    hashtag = false
                                    top = false
                                } label: {
                                    if live == true {
                                        Image("TvS2")
                                    }
                                    Text("Live")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundStyle( live ?
                                                          LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                            Color("gray"),
                                                            Color("gray"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                }
                                if live {
                                    Capsule()
                                        .fill(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .frame(width: 80, height: 4)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 0, height: 4)
                                }
                                
                            }
                            
                            VStack {
                                Button {
                                    all = false
                                    people = false
                                    videos = false
                                    sounds = false
                                    live = false
                                    hashtag = true
                                    top = false
                                } label: {
                                    Text("Hashtag")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundStyle( hashtag ?
                                                          LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                            Color("gray"),
                                                            Color("gray"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                }
                                if hashtag {
                                    Capsule()
                                        .fill(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .frame(width: 85, height: 4)
                                }
                                else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 0, height: 4)
                                }
                                
                            }
                            
                            VStack {
                                Button {
                                    all = false
                                    people = false
                                    videos = false
                                    sounds = false
                                    live = false
                                    hashtag = false
                                    top = true
                                } label: {
                                    Text("Top")
                                        .font(.custom("Urbanist-SemiBold", size: 18))
                                        .foregroundStyle( top ?
                                                          LinearGradient(colors: [
                                                            Color("buttionGradientTwo"),
                                                            Color("buttionGradientOne"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                            Color("gray"),
                                                            Color("gray"),
                                                          ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                }
                                if top {
                                    Capsule()
                                        .fill(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .frame(width: 45, height: 4)
                                }
                                else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 0, height: 2)
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                .padding(.bottom, 34)
                
            }
            
            
        }
//        .padding(.leading)
    }
}

struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
//        SearchButtonView(all: .constant(true), people: .constant(false), videos: .constant(false), sounds: .constant(false), live: .constant(false), hashtag: .constant(false), top: .constant(false))
        
        SearchView()
        
    }
}
