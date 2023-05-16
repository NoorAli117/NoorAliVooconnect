//
//  SearchTest.swift
//  Vooconnect
//
//  Created by Vooconnect on 13/12/22.
//

import SwiftUI

struct SearchTest: View {
    
    @State private var all: Bool = true
    @State private var people: Bool = false
    @State private var videos: Bool = false
    @State private var sounds: Bool = false
    @State private var live: Bool = false
    @State private var hashtag: Bool = false
    @State private var top: Bool = false
    
    var body: some View {
        VStack {
            
            ZStack {
                
                // All Button
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.gray)
                
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
                                        .frame(width: 60, height: 4)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 60, height: 2)
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
                                        .frame(width: 60, height: 4)
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
                                        .frame(width: 60, height: 4)
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
                                        .frame(width: 60, height: 4)
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
                                        .frame(width: 50, height: 4)
                                } else {
                                    Capsule()
                                        .fill(.clear)
                                        .frame(width: 60, height: 4)
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
                                        .frame(width: 60, height: 4)
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
                                        .frame(width: 60, height: 2)
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                .padding(.bottom, 34)
                
            }
            
            
        }
        .padding(.leading)
    }
}

struct SearchTest_Previews: PreviewProvider {
    static var previews: some View {
        SearchTest()
    }
}
