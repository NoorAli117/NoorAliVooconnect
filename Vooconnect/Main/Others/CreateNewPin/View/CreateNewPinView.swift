//
//  CreateNewPinView.swift
//  Vooconnect
//
//  Created by Vooconnect on 14/11/22.
//

import SwiftUI

struct CreateNewPinView: View {
    
    @StateObject var otpModel: OTPViewModel = .init()
    // MARK: TextField FocusState
    @FocusState var activeField: OTPField?
    @Environment(\.presentationMode) var presentaionMode
    @State private var chooseYourInterest: Bool = false
    
    @StateObject var otpViewModel = OTPViewModel()
    @State private var homePageView: Bool = false
    @State private var isLoaderPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLoaderPresented == true {
                    Color(#colorLiteral(red: 0.3257557154, green: 0.3457402587, blue: 0.379650116, alpha: 1))
                        .ignoresSafeArea()
                } else {
                    Color(.white)
                        .ignoresSafeArea()
                }
                
                VStack {
                    
                    NavigationLink(destination: HomePageView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $homePageView) {
                            EmptyView()
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Create New PIN")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .padding(.leading)
                    
//                    ScrollView {
                        
                        VStack {
                            
                                Text("Add a PIN number to make your account more secure.")
                                    .font(.custom("Urbanist-Medium", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                             
                                    .padding(.top, 60)
                                    .padding(.bottom, 60)
                            
                            VStack {
                                OTPField()
                            }
                            .onChange(of: otpModel.otpFields) { newValue in
                                OTPCondition(value: newValue)
                            }
                            .padding(.bottom, 60)
                            
                            Button {
                                isLoaderPresented.toggle()
                                delayTextTwo()
                            } label: {
                                Text("Continue")
                                    .font(.custom("Urbanist-Bold", size: 16))
                                    .padding(18)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
//                            if isLoaderPresented == true {
////                                .task(delayText)
//                                self.delayText()
//
//                            }
                            
                                Spacer()
                        }
                }
            }
        }
        
        .popup(isPresented: isLoaderPresented, alignment: .center, content: PopUpView.init)
//        .popup(isPresented: isLoaderPresented, content: PopUpView(image: "PopupLogoThree"))
    
        
    }
    
    // Delay
//    private func delayText() async {
//            // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
//            try? await Task.sleep(nanoseconds: 2_500_000_000)
//
//        isLoaderPresented = false
//        homePageView = true
//
//        }
    
    
    // Delay
    private func delayTextTwo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoaderPresented = false
            homePageView = true
        }
        
    }
    
    
    // MARK: Condition For Custom OTP Field $ Limiting Only one Text
    func OTPCondition(value: [String]) {
        
        // Moving Next Field If Current Field Type
        for index in 0..<3 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        // Moving Back if Current is Empty And Previous is not Empty
        for index in 1...3 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0..<4 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    // MARK: Custom OTP TextField
    @ViewBuilder
    func OTPField()->some View {
        HStack(spacing: 14) {
            ForEach(0..<4, id: \.self){ index in
                VStack(spacing: 8) {
                    TextField("", text: $otpModel.otpFields[index])
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField,equals: activeStateForIndex(index: index))
                        .font(Font.system(size: 22, design: .default))
                        .padding()
                    
                    //                        .background(activeField == activeStateForIndex(index: index) ? .red : .gray)
                    
                        .background(activeField == activeStateForIndex(index: index) ? Color(#colorLiteral(red: 0.5289534926, green: 0.2311087251, blue: 1, alpha: 0.08376448675)) : Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))
                    
                    
                        .overlay(activeField == activeStateForIndex(index: index) ? (RoundedRectangle(cornerRadius: 10).stroke(Color("buttionGradientOne"), lineWidth: 1).cornerRadius(10)) : (RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)), lineWidth: 1).cornerRadius(10)))
                    
                    
                    
                }
                .cornerRadius(10)
            }
            
        }
        
        .toolbar(content: {
            ToolbarItem(placement: .keyboard) {
                Spacer()
            }
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    activeField = nil
                }
            }
        })
        
        .padding(.horizontal)
    }
    
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        default: return .field4
            
        }
    
}
    
}

struct CreateNewPinView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPinView()
    }
}
