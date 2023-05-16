//
//  BirthDayView.swift
//  Vooconnect
//
//  Created by Vooconnect on 09/11/22.
//

import SwiftUI

struct BirthDayView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
           return formatter
       }()
    
    let dateFormatterr: DateFormatter = {
           let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
           return formatter
       }()
    
    @State var selectedDate = Date()
    @State var currentDate = Date()
    
    @State private var isEligble = false
    @State private var allert = false
    
    @State private var profileView: Bool = false
    
    @StateObject var birthDayVM = BirthDayViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    NavigationLink(destination: FillYourProfileView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $birthDayVM.birthDayDataModel.navigate) {
                            EmptyView()
                        }
                    
                    NavigationLink(destination: FillYourProfileView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $profileView) {
                            EmptyView()
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("When is Your Birthday?")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack {
                            
                            HStack {
                                Text("Your birthday will not be shown to the public.")
                                    .font(.custom("Urbanist-Medium", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
//                                    .multilineTextAlignment(.leading, 0)
//                                    .padding(.trailing)
                                    .padding(.top, 10)
                                Spacer()
                            }
                            
                            Image("BirthDayCake")
                                .resizable()
                                .frame(width: 220, height: 220)
                                .padding(.top, 40)
                                .padding(.bottom, 40)
                            
                            HStack {
                                Text(selectedDate, formatter: dateFormatter)
                                    .padding(.leading)
                                    .onChange(of: selectedDate) { newValue in
                                        
                                        let modifiedDate = Calendar.current.date(byAdding: .year, value: -13, to: currentDate)!
                                        print("Modified date", modifiedDate)
                                        
                                        if selectedDate > modifiedDate {
                                            // id will not be created
                                            print("I'm Less than 13")
                                            self.isEligble = false
                                        } else {
                                            // id will ne created
                                            print("I'm above 13")
                                            self.isEligble = true
                                        }

                                    }
                                Spacer()
                                Image("Calendar")
                                    .padding(.trailing)
                            }
                            .cornerRadius(12)
                            .frame(height: 56)
                            .background(Color("txtFieldBackgroun"))
                            
                            HStack(alignment: .center) {
                                DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                                    .datePickerStyle(.wheel)
                                    .fixedSize().frame(maxWidth: .infinity, alignment: .center)
//                                    .foregroundColor(.blue)

                            }
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            profileView.toggle()
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
                        
//                        var date = selectedDate, formatter: dateFormatter = <#value#>
                        
                        Button {
                            
                            
                            if isEligble {
//                                 Move to login screen
                                print("the yes this user is eligble")
//                                profileView.toggle()
                                birthDayVM.birthDayDataModel.birthDate = dateFormatterr.string(from: selectedDate)
                                
                                print(dateFormatter.string(from: selectedDate))
                                
                                birthDayVM.birthDayApi()
                                
                            } else {
                                
                                // show alert
                                print("this user is not eligble")
                                allert.toggle()
                                
                            }
                            
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
                        
                        .alert(isPresented: $allert, content: {
                            Alert(title: Text("Alert"), message: Text("Person should be at least 13 years old."), dismissButton: .cancel(Text("Ok")))
                        })
                        
                    }
                    .padding(.horizontal)
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct BirthDayView_Previews: PreviewProvider {
    static var previews: some View {
        BirthDayView()
    }
}
