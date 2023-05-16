//
//  ChooseYourTopicView.swift
//  Vooconnect
//
//  Created by Naveen Yadav on 04/04/23.
//

import SwiftUI

struct ChooseYourTopicView: View {
    
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
    
    @State var selectedValues = [String]()
    
    @State private var alert: Bool = false
    
    @Environment(\.presentationMode) var presentaionMode
    @Binding var presentedAsModal: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                    VStack {
                        
//                        NavigationLink(destination: GenderView()
//                            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $updateInterestVM.updateInterestDataModel.isPresentingSuccess) {
//                                EmptyView()
//                            }
//
//                        NavigationLink(destination: GenderView()
//                            .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $genderView) {
//                                EmptyView()
//                            }
                        
                        HStack {
                            Button {
                                presentaionMode.wrappedValue.dismiss()
                            } label: {
                                Image("BackButton")
                            }
                            
                            Text("Choose Your Topic")
                                .font(.custom("Urbanist-Bold", size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
//                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .padding()

                        ScrollView {
                            
                            VStack(spacing: 20) {
                                HStack {
                                    Text("Choose your post categories to help users find your video")
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
                                        print(selectedValues)
//                                        if selectedValues.count < 3 {
//                                            entertainment.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(1)
                                        manageSelection(str: "Entertainment") { value in
//                                            if value == true {
                                                entertainment.toggle()
//                                            }
                                        }
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
//                                        if selectedValues.count < 3 {
//                                            gaming.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(2)
                                        manageSelection(str: "Gaming") { value in
//                                            if value == true {
                                                gaming.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            art.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(3)
//                                        manageSelection(str: "Art")
                                        manageSelection(str: "Art") { value in
//                                            if value == true {
                                                art.toggle()
//                                            }
                                        }
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
//                                        if selectedValues.count < 3 {
//                                            animals.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(4)
//                                        manageSelection(str: "Animals")
                                        manageSelection(str: "Animals") { value in
//                                            if value == true {
                                                animals.toggle()
//                                            }
                                        }
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
//                                        if selectedValues.count < 3 {
//                                            comedy.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(5)
//                                        manageSelection(str: "Comedy")
                                        manageSelection(str: "Comedy") { value in
//                                            if value == true {
                                                comedy.toggle()
//                                            }
                                        }
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
//                                        if selectedValues.count < 3 {
//                                            dance.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(6)
//                                        manageSelection(str: "Dance")
                                        manageSelection(str: "Dance") { value in
//                                            if value == true {
                                                dance.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            beauty.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(7)
//                                        manageSelection(str: "Beauty")
                                        manageSelection(str: "Beauty") { value in
//                                            if value == true {
                                                beauty.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            music.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(8)
//                                        manageSelection(str: "Music")
                                        manageSelection(str: "Music") { value in
//                                            if value == true {
                                                music.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            foodAndDrink.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(9)
//                                        manageSelection(str: "Food & Drink")
                                        manageSelection(str: "Food & Drink") { value in
//                                            if value == true {
                                                foodAndDrink.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            sports.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(10)
//                                        manageSelection(str: "Sports")
                                        manageSelection(str: "Sports") { value in
//                                            if value == true {
                                                sports.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            scienceAndEducation.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(11)
//                                        manageSelection(str: "Science & Education")
                                        manageSelection(str: "Science & Education") { value in
//                                            if value == true {
                                                scienceAndEducation.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            travel.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(12)
//                                        manageSelection(str: "Travel")
                                        manageSelection(str: "Travel") { value in
//                                            if value == true {
                                                travel.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            family.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(13)
//                                        manageSelection(str: "Family")
                                        manageSelection(str: "Family") { value in
//                                            if value == true {
                                                family.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            animeAndMovie.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(14)
//                                        manageSelection(str: "Anime & Movie")
                                        manageSelection(str: "Anime & Movie") { value in
//                                            if value == true {
                                                animeAndMovie.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            technology.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(15)
//                                        manageSelection(str: "Technology")
                                        manageSelection(str: "Technology") { value in
//                                            if value == true {
                                                technology.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            outdoors.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(16)
//                                        manageSelection(str: "Outdoors")
                                        manageSelection(str: "Outdoors") { value in
//                                            if value == true {
                                                outdoors.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            culture.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(17)
//                                        manageSelection(str: "Culture")
                                        manageSelection(str: "Culture") { value in
//                                            if value == true {
                                                culture.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            health.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(18)
//                                        manageSelection(str: "Health")
                                        manageSelection(str: "Health") { value in
//                                            if value == true {
                                                health.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            comics.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(19)
//                                        manageSelection(str: "Comics")
                                        manageSelection(str: "Comics") { value in
//                                            if value == true {
                                                comics.toggle()
//                                            }
                                        }
                                        
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
//                                        if selectedValues.count < 3 {
//                                            diy.toggle()
//                                        }
                                        updateInterestVM.updateInterestDataModel.interestID.append(20)
//                                        manageSelection(str: "DIY")
                                        manageSelection(str: "DIY") { value in
//                                            if value == true {
                                                diy.toggle()
//                                            }
                                        }
                                        
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
                                    Text("Cancel")
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
                                    
//                                    if(updateInterestVM.validationUserInputss()) {
//                                        updateInterestVM.updateInterestApi()
                                    print(selectedValues)
                                        UserDefaults.standard.set(selectedValues, forKey: UserdefaultsKey.selectedTopics)
                                        presentaionMode.wrappedValue.dismiss()
//                                    } else {
//                                        alert = true
//                                    }
                                    
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
                                    Alert(title: Text("Alert"), message: Text("Please choose your topic"), dismissButton: .cancel(Text("Ok")))
                                })
                                
                            }
                            .padding(.horizontal)
                            
                    }
                }
            }
            .navigationBarHidden(true)
        }
        
    }
    
    
    func manageSelection(str: String, closure: (Bool) -> Void) {
        if selectedValues.contains(str) {
            selectedValues.removeAll { $0 == str }
            print(selectedValues)
            selectedValues = selectedValues
            closure(false)
        } else {
            if selectedValues.count < 3 {
                selectedValues.append(str)
                closure(true)
            }
        }
     }
}

//struct ChooseYourTopicView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseYourTopicView(presentedAsModal: <#Binding<Bool>#>)
//    }
//}
