//
//  GenderView.swift
//  Vooconnect
//
//  Created by Vooconnect on 09/11/22.
//

import SwiftUI

struct GenderView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    @State private var male: Bool = true
    @State private var female: Bool = false
    @State private var other: Bool = false
    
    @State private var birthDayView: Bool = false
    
    @StateObject var genderVM = GenderViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    NavigationLink(destination: BirthDayView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $genderVM.genderDataModel.navigate) {
                            EmptyView() // genderVM.genderDataModel.navigate
                        }
                    
                    NavigationLink(destination: BirthDayView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $birthDayView) {
                            EmptyView() // genderVM.genderDataModel.navigate
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Tell Us About Yourself")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            HStack {
                                Text("Choose your identity & help us to find accurate content for you.")
                                    .font(.custom("Urbanist-Medium", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .multilineTextAlignment(.leading)
                                    .padding(.trailing)
                                    .padding(.top, 10)
                                Spacer()
                            }
                            
                            Button {
                                if male == false {
                                    female = false
                                    other = false
                                    male = true
                                    
                                }
                                if male == true {
                                    genderVM.genderDataModel.gender = "male"
                                }
                                
                            } label: {
                                VStack {
                                    Image("Male")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        Text("Male")
                                        .font(.custom("Urbanist-Bold", size: 24))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 150, height: 150)
                                .background(male ? LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
//                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                    Color("LightGray"),
                                    Color("LightGray"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(75)
                            }
                            .padding(.top, 8)

                            Button {
                                if female == false {
                                    male = false
                                    other = false
                                    female = true
                                }
                                if female == true {
                                    genderVM.genderDataModel.gender = "female"
                                }
                            } label: {
                                VStack {
                                    Image("Female")
                                        .resizable()
                                        .frame(width: 30, height: 50)
                                        Text("Female")
                                        .font(.custom("Urbanist-Bold", size: 24))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 150, height: 150)
                                .background(female ? LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
//                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                    Color("LightGray"),
                                    Color("LightGray"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(75)
                            }
                            
                            Button {
                                if other == false {
                                    male = false
                                    female = false
                                    other = true
                                }
                                if other == true {
                                    genderVM.genderDataModel.gender = "other"
                                }
                                
                                
                            } label: {
                                VStack {
                                        Text("Other")
                                        .font(.custom("Urbanist-Bold", size: 24))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 150, height: 150)
                                .background(other ? LinearGradient(colors: [
                                    Color("buttionGradientTwo"),
                                    Color("buttionGradientOne"),
//                                    Color("buttionGradientOne"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                                    Color("LightGray"),
                                    Color("LightGray"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(75)
                            }
                            
                            HStack {
                                Button {
                                    birthDayView.toggle()
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
//                                    birthDayView.toggle()
                                    genderVM.genderApi()
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
                                
//                                .alert(isPresented: $genderVM.genderDataModel.isPresentingSuccess, content: {
//                                    Alert(title: Text("Alert"), message: Text(genderVM.genderDataModel.successMessage), dismissButton: .default(Text("Ok"), action: {
//                                        print("Navigateee==========")
//                                        birthDayView = true
//                                    }))
//                                })
                                
                            }
                            .padding(.top, 8)
                            
                        }
                        .padding(.horizontal)
                    }
                    
//                    Spacer()
                }
                
            }
            .navigationBarHidden(true)
            
        }
       
    }
}

struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView()
    }
}
