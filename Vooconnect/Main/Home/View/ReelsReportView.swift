//
//  ReelsReportView.swift
//  Vooconnect
//
//  Created by Vooconnect on 04/01/23.
//

import SwiftUI

struct ReelsReportView: View {
    
    @Environment(\.presentationMode) var presentaionMode
        @State private var slected: String = ""
        @StateObject private var likeVM: ReelsLikeViewModel = ReelsLikeViewModel()
        
        var body: some View {
            NavigationView {
                ZStack {
                    Color(.white)
                        .ignoresSafeArea()
                    
                    VStack {
                        
    //                    NavigationLink(destination: FillYourProfileView()
    //                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $birthDayVM.birthDayDataModel.navigate) {
    //                            EmptyView()
    //                        }
                        
                        HStack {
                            Button {
                                presentaionMode.wrappedValue.dismiss()
                            } label: {
                                Image("BackButton")
                            }
                            
                            Text("Report")
                                .font(.custom("Urbanist-Bold", size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        HStack {
                            
                            Text("Select a reason")
                                .font(.custom("Urbanist-Medium", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))

                            
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top)
                        
                        ScrollView {
                            
                            VStack(spacing: 23) {
                                
                                // 1
                                HStack {
                                    
                                    Button {
                                        slected = "Dangerous organizations/individuals"
                                    } label: {
                                        Image(slected == "Dangerous organizations/individuals" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Dangerous organizations/individuals")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 2
                                HStack {
                                    
                                    Button {
                                        slected = "Frauds & Scams"
                                    } label: {
                                        Image(slected == "Frauds & Scams" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Frauds & Scams")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 3
                                HStack {
                                    
                                    Button {
                                        slected = "Misleading Information"
                                    } label: {
                                        Image(slected == "Misleading Information" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Misleading Information")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 4
                                HStack {
                                    
                                    Button {
                                        slected = "Illegal activities or regulated goods"
                                    } label: {
                                        Image(slected == "Illegal activities or regulated goods" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Illegal activities or regulated goods")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 5
                                HStack {
                                    
                                    Button {
                                        slected = "Violent & graphic contents"
                                    } label: {
                                        Image(slected == "Violent & graphic contents" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Violent & graphic contents")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 6
                                HStack {
                                    
                                    Button {
                                        slected = "Animal Cruelty"
                                    } label: {
                                        Image(slected == "Animal Cruelty" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Animal Cruelty")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 7
                                HStack {
                                    
                                    Button {
                                        slected = "Pornography & nudity"
                                    } label: {
                                        Image(slected == "Pornography & nudity" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Pornography & nudity")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 8
                                HStack {
                                    
                                    Button {
                                        slected = "Hate Speech"
                                    } label: {
                                        Image(slected == "Hate Speech" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Hate Speech")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 9
                                HStack {
                                    
                                    Button {
                                        slected = "Harrashment or bullying"
                                    } label: {
                                        Image(slected == "Harrashment or bullying" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Harrashment or bullying")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 10
                                HStack {
                                    
                                    Button {
                                        slected = "Intelectual property infringement"
                                    } label: {
                                        Image(slected == "Intelectual property infringement" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Intelectual property infringement")
                                    
                                    Spacer()
                                    
                                }
                                
                            }
                            .font(.custom("Urbanist-Medium", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                            .padding(.leading)
                            .padding(.top, 10)
                            
                            VStack(spacing: 23) {
                                
                                // 11
                                HStack {
                                    
                                    Button {
                                        slected = "Spam"
                                    } label: {
                                        Image(slected == "Spam" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Spam")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 12
                                HStack {
                                    
                                    Button {
                                        slected = "Minor Safety"
                                    } label: {
                                        Image(slected == "Minor Safety" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Minor Safety")
                                    
                                    Spacer()
                                    
                                }
                                
                                // 13
                                HStack {
                                    
                                    Button {
                                        slected = "Other"
                                    } label: {
                                        Image(slected == "Other" ? "RadioLS" :"UnSelectedReportIcon")  // RadioLS
                                    }
                                    
                                    Text("Other")
                                    
                                    Spacer()
                                    
                                }
                            }
                            .font(.custom("Urbanist-Medium", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 0.9040511175)))
                            .padding(.leading)
                            .padding(.top, 10)
                            
                        }
                        
                        HStack {
                            
                            Button {
                                presentaionMode.wrappedValue.dismiss()
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
                                likeVM.abuseReportPostApi(desc: slected)
                                presentaionMode.wrappedValue.dismiss()
                            } label: {
                                Spacer()
                                Text("Submit")
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
                            
                        }
                        .padding(.horizontal)
                        
                    }
                }
            }
        }
}

struct ReelsReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsReportView()
    }
}
