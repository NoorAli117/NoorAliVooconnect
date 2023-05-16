//
//  SearchView.swift
//  Vooconnect
//
//  Created by Vooconnect on 12/12/22.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    @State private var userName: String = ""
    
    @State private var all: Bool = true
    @State private var people: Bool = false
    @State private var videos: Bool = false
    @State private var sounds: Bool = false
    @State private var live: Bool = false
    @State private var hashtag: Bool = false
    @State private var top: Bool = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    // Top Search Bar
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                                .padding(.trailing, 10)
                        }
                        
                            HStack {
                                Image("SearchS")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .padding(.leading)
                                TextField("Search", text: $userName)
                                    .frame(height: 20, alignment: .center)
                                Image("FilterS")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .padding(.trailing)
                            }
                            
                            .frame(height: 55)
                                        .background(Color(#colorLiteral(red: 0.9688159823, green: 0.9688159823, blue: 0.9688159823, alpha: 1)))
                                        .cornerRadius(10)
                        
                    }
                    .padding(.horizontal)
                    
                    SearchButtonView(all: $all, people: $people, videos: $videos, sounds: $sounds, live: $live, hashtag: $hashtag, top: $top)
                        .padding(.top)
//                        .background(Color.gray)
                        .padding(.bottom, -20)
                        .padding(.leading)
                    
                    ScrollView {
                        
                        // Alll
                        if all == true {
                                // Creators
                                VStack {

                                    HStack {
                                        Text("Creators")
                                            .font(.custom("Urbanist-Bold", size: 20))
                                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                        Spacer()
                                    }

                                    HStack {

                                        VStack {
                                            Image("squareS")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                                .overlay(
                                                    Image("PremiumBadgeS")
                                                        .padding(.leading, 6)
                                                    , alignment: .topLeading
                                                        
                                                )
                                                
                                            Text("Ariana Grande")
                                                .font(.custom("Urbanist-Bold", size: 18))
                                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                            Text("arianagrande | 27.3M followers")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                                            Button {

                                            } label: {
                                                HStack{
                                                    Text("Follow")
                                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                                        .foregroundColor(Color.white)
                                                        .padding(6)
                                                        .padding(.horizontal, 30)
                                                }
                                                .padding(.horizontal, 10)
                                                .background(LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                  ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .cornerRadius(20)
                                            }


                                        }

                                        VStack {
                                            Image("squareS")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                                .overlay(
                                                    Image("PremiumBadgeS")
                                                        .padding(.leading, 6)
                                                    , alignment: .topLeading
                                                        
                                                )
                                            Text("Ariana Grande")
                                                .font(.custom("Urbanist-Bold", size: 18))
                                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                            Text("arianagrande | 27.3M followers")
                                                .font(.custom("Urbanist-SemiBold", size: 10))
                                                .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                                            Button {

                                            } label: {
                                                HStack{
                                                    Text("Follow")
                                                        .font(.custom("Urbanist-SemiBold", size: 14))
                                                        .foregroundColor(Color.white)
                                                        .padding(6)
                                                        .padding(.horizontal, 30)
                                                }
                                                .padding(.horizontal, 10)
                                                .background(LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                  ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .cornerRadius(20)
                                            }


                                        }

                                    }

                                    Button {

                                    } label: {
                                        Text("View More")
                                            .font(.custom("Urbanist-SemiBold", size: 14))
                                            .frame(width: 150, height: 32, alignment: .center)
                                            .foregroundColor(.black)
                                            .background(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.1989083195)))
                                            .cornerRadius(20)
                                    }


                                }
                                .padding(.horizontal)

                                // Users
                                VStack {
                                    HStack {
                                        Text("Users")
                                            .font(.custom("Urbanist-Bold", size: 20))
                                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                        Spacer()
                                    }
                                    .padding(.bottom, -1)
                                    HStack {
                                        Image("squareTwoS")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(10)
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("Ariana Cooper")
                                                .font(.custom("Urbanist-Bold", size: 18))
                                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                            Text("arianacooper | 24.5M followers")
                                                .font(.custom("Urbanist-SemiBold", size: 14))
                                                .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                                        }
                                        .padding(.leading, 10)
                                        Spacer()
                                        Button {

                                        } label: {
                                            Text("Follow")
                                                .font(.custom("Urbanist-SemiBold", size: 14))
                                                .foregroundColor(Color.white)
                                                .frame(width: 73, height: 32)
                                                .background(LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                  ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .cornerRadius(20)
                                        }

                                    }

                                    HStack {
                                        Image("squareTwoS")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(10)
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("Ariana Cooper")
                                                .font(.custom("Urbanist-Bold", size: 18))
                                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                            Text("arianacooper | 24.5M followers")
                                                .font(.custom("Urbanist-SemiBold", size: 14))
                                                .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                                        }
                                        .padding(.leading, 10)
                                        Spacer()
                                        Button {

                                        } label: {
                                            Text("Follow")
                                                .font(.custom("Urbanist-SemiBold", size: 14))
                                                .foregroundColor(Color.white)
                                                .frame(width: 73, height: 32)
                                                .background(LinearGradient(colors: [
                                                    Color("buttionGradientTwo"),
                                                    Color("buttionGradientOne"),
                                                  ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .cornerRadius(20)
                                        }

                                    }

                                    Button {

                                    } label: {
                                        Text("View More")
                                            .font(.custom("Urbanist-SemiBold", size: 14))
                                            .frame(width: 150, height: 32, alignment: .center)
                                            .foregroundColor(.black)
                                            .background(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.1989083195)))
                                            .cornerRadius(20)
                                    }


                                }
                                .padding(.horizontal)

                                // Videos
                                VStack {
                                    HStack {
                                        Text("Videos")
                                            .font(.custom("Urbanist-Bold", size: 20))
                                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                        Spacer()
                                    }
                                    .padding(.bottom, -1)

                                    HStack {
                                        Image("ImageS")
                                            .frame(width: 84, height: 138)
                                            .cornerRadius(12)
                                            .overlay {
                                                VStack {
                                                    HStack {
                                                        Image("PremiumBadgeS2")
//                                                        Image("PremiumS")
//                                                        Spacer()
                                                    }
                                                    Spacer()
                                                    HStack {
                                                        Image("PlayS")
                                                        Text("736.2K")
                                                            .font(.custom("Urbanist-SemiBold", size: 10))
                                                            .foregroundColor(.white)
                                                            
                                                        Spacer()
                                                    }
                                                    .padding(.leading, 6)
                                                    .padding(.bottom, 3)
                                                }

                                            }
                                        Spacer()
                                        Image("ImageS")
                                        Spacer()
                                        Image("ImageS")
                                        Spacer()
                                        Image("ImageS")
                                            .frame(width: 84, height: 138)
                                            .cornerRadius(12)
                                            .overlay {
                                                VStack {
                                                    HStack {
                                                        Image("PremiumBadgeS2")
//                                                        Image("PremiumS")
//                                                        Spacer()
                                                    }
                                                    Spacer()
                                                    HStack {
                                                        Image("PlayS")
                                                        Text("736.2K")
                                                            .font(.custom("Urbanist-SemiBold", size: 10))
                                                            .foregroundColor(.white)
                                                            
                                                        Spacer()
                                                    }
                                                    .padding(.leading, 6)
                                                    .padding(.bottom, 3)
                                                }

                                            }
                                    }

                                    Button {

                                    } label: {
                                        Text("View More")
                                            .font(.custom("Urbanist-SemiBold", size: 14))
                                            .frame(width: 150, height: 32, alignment: .center)
                                            .foregroundColor(.black)
                                            .background(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.1989083195)))
                                            .cornerRadius(20)
                                    }


                                }
                                .padding(.horizontal)

                                // Sounds
                                VStack {

                                    HStack {
                                        Text("Sounds")
                                            .font(.custom("Urbanist-Bold", size: 20))
                                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                        Spacer()
                                    }
                                    .padding(.bottom, -1)

                                    HStack {
                                        Image("ImageTwoS")
                                        VStack(alignment: .leading) {
                                            Text("Side to Side")
                                                .font(.custom("Urbanist-Bold", size: 16))
                                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                            Text("Ariana Grande: 0:30")
                                                .font(.custom("Urbanist-Regular", size: 12))
                                                .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
//                                                .padding(.top,1)
                                            HStack {
                                                Image("tvS")
                                                Text("938.6K")
                                                    .font(.custom("Urbanist-SemiBold", size: 14))
                                                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                                            }
                                            .padding(.top, -6)
                                        }
                                        .padding(.leading, 8)

                                        Spacer()

                                        Image("ImageTwoS")
                                        VStack(alignment: .leading) {
                                            Text("Side to Side")
                                                .font(.custom("Urbanist-Bold", size: 16))
                                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9007915977)))
                                            Text("Ariana Grande: 0:30")
                                                .font(.custom("Urbanist-Regular", size: 12))
                                                .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                                            HStack {
                                                Image("tvS")
                                                Text("938.6K")
                                                    .font(.custom("Urbanist-SemiBold", size: 14))
                                                    .foregroundColor(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.7024782699)))
                                            }
                                            .padding(.top, -6)
                                        }

                                    }

                                    Button {

                                    } label: {
                                        Text("View More")
                                            .font(.custom("Urbanist-SemiBold", size: 14))
                                            .frame(width: 150, height: 32, alignment: .center)
                                            .foregroundColor(.black)
                                            .background(Color(#colorLiteral(red: 0.4560062289, green: 0.4560062289, blue: 0.4560062289, alpha: 0.1989083195)))
                                            .cornerRadius(20)
                                    }


                                }
                                .padding(.horizontal)
                            
                        } else if people == true {
                            
                            LazyVGrid(columns: gridLayoutP, alignment: .center, spacing: columnSpacingP, pinnedViews: []) {
                                Section()
                                {
                                    ForEach(0..<10) { people in
                                        PeopleListView()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                        } else if videos == true {
                            LazyVGrid(columns: gridLayoutV, alignment: .center, spacing: columnSpacingV, pinnedViews: []) {
                                Section()
                                {
                                    ForEach(0..<10) { people in
                                        SearchVideosView()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 4)
                            
                        } else if sounds == true { // SearchSoundsView()
                            
                            LazyVGrid(columns: gridLayoutS, alignment: .center, spacing: columnSpacingS, pinnedViews: []) {
                                Section()
                                {
                                    ForEach(0..<10) { people in
                                        SearchSoundsView()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                        } else if live == true {  // SearchLiveView()
                            LazyVGrid(columns: gridLayoutL, alignment: .center, spacing: columnSpacingL, pinnedViews: []) {
                                Section()
                                {
                                    ForEach(0..<10) { people in
                                        SearchLiveView()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 4)
                            
                        } else if hashtag == true {  // SearchHashtagView()
                            LazyVGrid(columns: gridLayoutS, alignment: .center, spacing: columnSpacingS, pinnedViews: []) {
                                Section()
                                {
                                    ForEach(0..<10) { people in
                                        SearchHashtagView()
                                    }
                                }
                            }
//                            .padding(.top, 10)
                            .padding(.horizontal)
                        }
                        
                    }
//                    .padding(.top)
                    
                }
//                .padding(.horizontal)
            }
            
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
