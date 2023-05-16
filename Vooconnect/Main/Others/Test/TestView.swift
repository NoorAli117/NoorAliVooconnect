//
//  TestView.swift
//  Vooconnect
//
//  Created by Vooconnect on 10/11/22.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button {

            } label: {
                Text("Sign in with Email")
                    .font(.custom("Urbanist-Bold", size: 16))
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [
                            Color("buttionGradientTwo"),
                            Color("buttionGradientOne"),
                            Color("buttionGradientOne"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(40)
                    .foregroundColor(.white)
                
            }
            
            Button {

            } label: {
                Text("Sign in with Email")
                    .font(.custom("Urbanist-Bold", size: 16))
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [
                            Color("ButtonTestTwo"),
                            Color("ButtonTestOne"),
                            
//                            Color("ButtonTestOne"),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(40)
                    .foregroundColor(.white)
                
            }
            
            Button {

            } label: {
                ZStack {
                    Image("Button")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
//                        .clipped()
                        .padding(.horizontal, -25)
                    
                    Text("Sign in with Email")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundColor(.white)
                        .offset(y: -5)
                }
//                .frame(maxWidth: .infinity)
            }

        }
        .padding(.horizontal)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

// SignUP Succes

//"status": true,
//    "message": "OTP sent.",
//    "data": {
//        "uuid": "0c1bb823-8ef2-4c1c-8b9a-da09fcefce83"
//    }

// SignUP Failure

//{
//    "status": false,
//    "errors": [
//        {
//            "value": "sajid1@vooconnect.com",
//            "msg": "Email is already taken.",
//            "param": "email",
//            "location": "body"
//        }
//    ]
//}


// Invalid OTP.

//{
//    "status": false,
//    "message": "Invalid OTP."
//}


// Email verified.

//{
//    "status": true,
//    "message": "Email verified.",
//    "data": {
//        "id": 39,
//        "uuid": "0c1bb823-8ef2-4c1c-8b9a-da09fcefce83",
//        "username": null,
//        "first_name": null,
//        "last_name": null,
//        "middle_name": null,
//        "gender": null,
//        "birthdate": null,
//        "phone": null,
//        "phone_verified_at": null,
//        "email": "sajid1@vooconnect.com",
//        "email_verified_at": null,
//        "password": "1122334455",
//        "profile_image": null,
//        "otp": 1234,
//        "status": "active",
//        "deleted_at": null,
//        "created_at": "2022-11-11T09:56:15.000Z",
//        "updated_at": "2022-11-11T09:56:15.000Z"
//    }
//}


// When Email is Varified
//{
//    "status": true,
//    "data": {
//        "id": 39,
//        "uuid": "0c1bb823-8ef2-4c1c-8b9a-da09fcefce83",
//        "username": null,
//        "first_name": null,
//        "last_name": null,
//        "middle_name": null,
//        "gender": null,
//        "birthdate": null,
//        "phone": null,
//        "phone_verified_at": null,
//        "email": "sajid1@vooconnect.com",
//        "email_verified_at": "2022-11-11T10:02:19.000Z",
//        "password": "1122334455",
//        "profile_image": null,
//        "otp": 1234,
//        "status": "active",
//        "deleted_at": null,
//        "created_at": "2022-11-11T09:56:15.000Z",
//        "updated_at": "2022-11-11T10:02:19.000Z"
//    }
//}
