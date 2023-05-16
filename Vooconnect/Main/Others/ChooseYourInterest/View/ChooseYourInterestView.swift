//
//  ChooseYourInterestView.swift
//  Vooconnect
//
//  Created by sajid shaikh on 07/11/22.
//

import SwiftUI

struct ChooseYourInterestView: View {
    
    @State private var entertainment: Bool = false
    @State private var gaming: Bool = false
    @State private var art: Bool = false
    @State private var animals: Bool = false
    @State private var comedy: Bool = false
    @State private var dance: Bool = false
    @State private var beauty: Bool = false
    @State private var music: Bool = false
    @State private var foodAndDrink: Bool = false
    @State private var sports: Bool = false
    @State private var diy: Bool = false
    @State private var scienceAndEducation: Bool = false
    @State private var travel: Bool = false
    @State private var family: Bool = false
    @State private var animeAndMovie: Bool = false
    @State private var technology: Bool = false
    @State private var outdoors: Bool = false
    @State private var culture: Bool = false
    @State private var health: Bool = false
    @State private var comics: Bool = false
    
    @State private var genderView: Bool = false
    
    @StateObject var updateInterestVM = UpdateInterestViewModel()
    
    @State private var alert: Bool = false
    
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                    VStack {
                        
                        NavigationLink(destination: GenderView()
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $updateInterestVM.updateInterestDataModel.isPresentingSuccess) {
                                EmptyView()
                            }
                        
                        NavigationLink(destination: GenderView()
                            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $genderView) {
                                EmptyView()
                            }
                        
                        HStack {
                            Button {
                                presentaionMode.wrappedValue.dismiss()
                            } label: {
                                Image("BackButton")
                            }
                            
                            Text("Choose Your Interest")
                                .font(.custom("Urbanist-Bold", size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
//                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .padding(.leading)

                        ScrollView {
                            
                            VStack(spacing: 20) {
                                HStack {
                                    Text("Choose your interests and get the best video recommendations.")
                                        .font(.custom("Urbanist-Medium", size: 18))
                                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                        .multilineTextAlignment(.leading)
                                        .padding(.trailing)
                                        .padding(.top, 10)
                                    Spacer()
                                }
                                //Urbanist-Medium.ttf
                                
                                // One 1
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        entertainment.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(1)
                                    } label: {
                                        Text("Entertainment")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(entertainment ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(entertainment ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(entertainment ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
//                                    .background(
//                                        LinearGradient(colors: [
//                                            Color("buttionGradientTwo"),
//                                            Color("buttionGradientOne"),
//                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
//                                    )
                                    
                                    Button {
                                        gaming.toggle()
                                        
                                        updateInterestVM.updateInterestDataModel.interestID.append(2)
                                        
                                    } label: {
                                        Text("Gaming")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(gaming ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(gaming ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(gaming ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Spacer()
                                }
                                
                                // One 2
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        art.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(3)
                                    } label: {
                                        Text("Art")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(art ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(art ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(art ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        animals.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(4)
                                    } label: {
                                        Text("Animals")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(animals ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(animals ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(animals ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        comedy.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(5)
                                    } label: {
                                        Text("Comedy")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(comedy ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(comedy ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(comedy ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Spacer()
                                }
                                
                                // One 3
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        dance.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(6)
                                    } label: {
                                        Text("Dance")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(dance ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(dance ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(dance ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        beauty.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(7)
                                    } label: {
                                        Text("Beauty")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(beauty ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(beauty ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(beauty ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        music.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(8)
                                    } label: {
                                        Text("Music")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(music ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(music ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(music ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Spacer()
                                }
                                
                                // One 4
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        foodAndDrink.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(9)
                                    } label: {
                                        Text("Food & Drink")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(foodAndDrink ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(foodAndDrink ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(foodAndDrink ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        sports.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(10)
                                    } label: {
                                        Text("Sports")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(sports ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(sports ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(sports ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    
                                    Spacer()
                                }
                                
                                // One 5
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        scienceAndEducation.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(11)
                                    } label: {
                                        Text("Science & Education")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(scienceAndEducation ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(scienceAndEducation ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(scienceAndEducation ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        travel.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(12)
                                    } label: {
                                        Text("Travel")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(travel ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(travel ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(travel ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    
                                    Spacer()
                                }
                                
                                // One 6
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        family.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(13)
                                    } label: {
                                        Text("Family")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(family ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(family ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(family ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        animeAndMovie.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(14)
                                    } label: {
                                        Text("Anime & Movie")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(animeAndMovie ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(animeAndMovie ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(animeAndMovie ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    
                                    Spacer()
                                }
                                
                                // One 7
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        technology.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(15)
                                    } label: {
                                        Text("Technology")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(technology ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(technology ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(technology ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        outdoors.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(16)
                                    } label: {
                                        Text("Outdoors")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(outdoors ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(outdoors ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(outdoors ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    
                                    Spacer()
                                }
                                
                                // One 8
                                HStack(spacing: 17) {
                                    
                                    Button {
                                        culture.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(17)
                                    } label: {
                                        Text("Culture")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(culture ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(culture ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(culture ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Button {
                                        health.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(18)
                                    } label: {
                                        Text("Health")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(health ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(health ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(health ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Spacer()
                                }
                                
                                // One 9
                                HStack(spacing: 17) {
                                    Button {
                                        comics.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(19)
                                    } label: {
                                        Text("Comics")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(comics ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(comics ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(comics ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    
                                    Button {
                                        diy.toggle()
                                        updateInterestVM.updateInterestDataModel.interestID.append(20)
                                    } label: {
                                        Text("DIY")
                                            .font(.custom("Urbanist-Bold", size: 18))
                                            .foregroundColor(diy ? .white : Color("buttionGradientOne"))
                                            .padding(.horizontal, 22)
                                            .padding(.vertical, 10)
                                            .background(diy ? LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                                Color.clear,
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .cornerRadius(25)
                                            .overlay(diy ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
                                    }
                                    
                                    Spacer()
                                }
                                
                            }
                            .padding(.leading)
                            .padding(.bottom, 40)
                            
                            HStack {
                                Button {
                                    genderView.toggle()
                                } label: {
                                    Spacer()
                                    Text("Skip")
                                        .font(.custom("Urbanist-Bold", size: 16))
                                        .foregroundStyle(
                                            LinearGradient(colors: [
                                                Color("buttionGradientTwo"),
                                                Color("buttionGradientOne"),
                                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .padding()
                                    Spacer()
                                }
                                .background(Color("SkipButtonBackground"))
                                .cornerRadius(40)
                                
                                Spacer()
                                Spacer()
                                
                                Button {
                                    //                                    genderView.toggle()
                                    
                                    if(updateInterestVM.validationUserInputss()) {
                                        updateInterestVM.updateInterestApi()
                                    } else {
                                        alert = true
                                    }
                                    
//                                    if updateInterestVM.updateInterestDataModel.interestID == nil {
//                                        alert = true
//                                    } else {
//                                        updateInterestVM.updateInterestApi()
//                                    }
                                    
                                    
                                } label: {
                                    Spacer()
                                    Text("Continue")
                                        .font(.custom("Urbanist-Bold", size: 16))
                                        .foregroundColor(.white)
                                        .padding()
                                    Spacer()
                                }
                                .background(
                                    LinearGradient(colors: [
                                        Color("buttionGradientTwo"),
                                        Color("buttionGradientOne"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .cornerRadius(40)
                                
                                .alert(isPresented: $alert, content: {
                                    Alert(title: Text("Alert"), message: Text("Please choose your interest"), dismissButton: .cancel(Text("Ok")))
                                })
                                
                            }
                            .padding(.horizontal)
                            
                    }
                }
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct ChooseYourInterestView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseYourInterestView()
    }
}
