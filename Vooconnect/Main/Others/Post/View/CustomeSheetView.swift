//
//  CustomeSheetView.swift
//  Vooconnect
//
//  Created by Vooconnect on 07/12/22.
//FinalPreviewModel

import SwiftUI

struct CustomeSheetView: View {
    
    @EnvironmentObject var finalPreviewModel: FinalPreviewModel
    
    @State private var isOn = false
    @State private var friendsOn = false
    @State private var onlyMeOn = false
    @State private var premiumFollowersOn = false
    @State private var premiumPlanOneOn = false
    @State private var premiumPlanTwoOn = false
    var callback : (TypeOfVisibility) -> () = {val in}
    @State private var typeOfVisibility = TypeOfVisibility.everyone
    var body: some View {
        VStack {
            Text("This post will be visible to")
                .font(.custom("Urbanist-Bold", size: 24))
            
            VStack {
                
                HStack {
                    Text("Everyone")
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(.black)
                    
                    
                    Spacer()
                    
                    Button {
                        isOn.toggle()
                        friendsOn = false
                        onlyMeOn = false
                        premiumFollowersOn = false
                        typeOfVisibility = TypeOfVisibility.everyone
                        callback(typeOfVisibility)
                    } label: {
                        ZStack {
                            if isOn {
                                Circle()
                                    .fill((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    .frame(width: 14, height: 14)
                                Circle()
                                    .strokeBorder((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)), lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            } else {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            }
                            
                        }
                    }

                    
                }
                
                HStack {
                    Text("Friends")
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        friendsOn.toggle()
                        isOn = false
                        onlyMeOn = false
                        premiumFollowersOn = false
                        typeOfVisibility = TypeOfVisibility.friends
                        callback(typeOfVisibility)
                    } label: {
                        ZStack {
                            if friendsOn {
                                Circle()
                                    .fill((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    .frame(width: 14, height: 14)
                                Circle()
                                    .strokeBorder((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)), lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            } else {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            }
                            
                        }
                    }
                }
                
                HStack {
                    Text("Only me")
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        onlyMeOn.toggle()
                        isOn = false
                        friendsOn = false
                        premiumFollowersOn = false
                        typeOfVisibility = TypeOfVisibility.onlyMe
                        callback(typeOfVisibility)
                    } label: {
                        ZStack {
                            if onlyMeOn {
                                Circle()
                                    .fill((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    .frame(width: 14, height: 14)
                                Circle()
                                    .strokeBorder((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)), lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            } else {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            }
                            
                        }
                    }
                    
                }
                
                HStack {
                    Text("Premium Followers")
                        .font(.custom("Urbanist-SemiBold", size: 18))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        premiumFollowersOn.toggle()
                        isOn = false
                        friendsOn = false
                        onlyMeOn = false
                        typeOfVisibility = TypeOfVisibility.premiumFollowers
                        callback(typeOfVisibility)
                    } label: {
                        ZStack {
                            if premiumFollowersOn {
                                Circle()
                                    .fill((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    .frame(width: 14, height: 14)
                                Circle()
                                    .strokeBorder((
                                        LinearGradient(colors: [
                                            Color("buttionGradientTwo"),
                                            Color("buttionGradientOne"),
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)), lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            } else {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 3)
                                    .frame(width: 24, height: 24)
                            }
                            
                        }
                    }
                    
                }
                
                if premiumFollowersOn {
                    VStack {
                        
                        HStack {
                            Image("TrangleLogo")
                                .frame(width: 44, height: 27)
                            Spacer()
                            
                        }
                        .padding(.leading, 30)
                        .padding(.vertical, -10)
                        
                        VStack {
                            
                            HStack {
                                Text("Premium Plan 1")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Button {
                                    premiumPlanOneOn.toggle()
                                    premiumPlanTwoOn = false
                                } label: {
                                    ZStack {
                                        if premiumPlanOneOn {
                                            Circle()
                                                .fill((
                                                    LinearGradient(colors: [
                                                        Color("buttionGradientTwo"),
                                                        Color("buttionGradientOne"),
                                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                                .frame(width: 14, height: 14)
                                            Circle()
                                                .strokeBorder((
                                                    LinearGradient(colors: [
                                                        Color("buttionGradientTwo"),
                                                        Color("buttionGradientOne"),
                                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)), lineWidth: 3)
                                                .frame(width: 24, height: 24)
                                        } else {
                                            Circle()
                                                .strokeBorder(.black, lineWidth: 3)
                                                .frame(width: 24, height: 24)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                            HStack {
                                Text("Premium Plan 2")
                                    .font(.custom("Urbanist-SemiBold", size: 18))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Button {
                                    premiumPlanTwoOn.toggle()
                                    premiumPlanOneOn = false
                                } label: {
                                    ZStack {
                                        if premiumPlanTwoOn {
                                            Circle()
                                                .fill((
                                                    LinearGradient(colors: [
                                                        Color("buttionGradientTwo"),
                                                        Color("buttionGradientOne"),
                                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                                .frame(width: 14, height: 14)
                                            Circle()
                                                .strokeBorder((
                                                    LinearGradient(colors: [
                                                        Color("buttionGradientTwo"),
                                                        Color("buttionGradientOne"),
                                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)), lineWidth: 3)
                                                .frame(width: 24, height: 24)
                                        } else {
                                            Circle()
                                                .strokeBorder(.black, lineWidth: 3)
                                                .frame(width: 24, height: 24)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder((LinearGradient(colors: [
                                    Color("GradientOne"),
                                    Color("GradientTwo"),
                                ], startPoint: .top, endPoint: .bottom)
                                ), lineWidth: 2)
                        }
                        
                    }
                    .padding(.horizontal)
                }
                
              
                
            }
            Spacer()
        }
        
        .padding(.horizontal)
        
    }
}

struct CustomeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomeSheetView()
    }
}



//struct Triangle: Shape {
//
//    func path(in rect: CGRect) -> Path {
//        Path { path in
//            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//        }
//    }
//}


//                        Rectangle()
//                            .trim(from: 0.5, to: 1)
//                            .frame(width: 50, height: 50)
//                            .rotationEffect(Angle(degrees: 135))

//                        Triangle()
//                            .stroke(style: StrokeStyle(lineWidth: 3))
//                            .frame(width: 44, height: 27)
//                            .foregroundColor(.purple)
////                            .overlay {
////                                RoundedRectangle(cornerRadius: 0)
//                                    .foregroundColor((LinearGradient(colors: [
//                                        Color("GradientOne"),
//                                        Color("GradientTwo"),
//                                    ], startPoint: .top, endPoint: .bottom)
//                                    )
////                                                     , lineWidth: 2
//                                    )
//                            }

//                    }





//struct CheckToggleStylee: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        Button {
//            configuration.isOn.toggle()
//        } label: {
//            Label {
//                configuration.label
//            } icon: {
//
//                ZStack {
//                    if configuration.isOn {
//                        Circle()
//                            .fill((
//                                LinearGradient(colors: [
//                                    Color("buttionGradientTwo"),
//                                    Color("buttionGradientOne"),
//                                ], startPoint: .topLeading, endPoint: .bottomTrailing)))
//                            .frame(width: 14, height: 14)
//                        Circle()
//                            .strokeBorder((
//                                LinearGradient(colors: [
//                                    Color("buttionGradientTwo"),
//                                    Color("buttionGradientOne"),
//                                ], startPoint: .topLeading, endPoint: .bottomTrailing)), lineWidth: 3)
//                            .frame(width: 24, height: 24)
//                    } else {
//                        Circle()
//                            .strokeBorder(.black, lineWidth: 3)
//                            .frame(width: 24, height: 24)
//                    }
//
//                }
//
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
