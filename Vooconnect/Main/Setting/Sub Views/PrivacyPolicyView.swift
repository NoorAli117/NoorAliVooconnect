//
//  PrivacyPolicyView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/01/23.
//

import SwiftUI

struct PrivacyPolicyView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            
            VStack {
                
//                    NavigationLink(destination: FillYourProfileView()
//                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $birthDayVM.birthDayDataModel.navigate) {
//                            EmptyView()
//                        }
                
                // Back Button
                HStack {
                    Button {
                        presentaionMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackButton")
                    }
                    
                    Text("Privacy Policy")
                        .font(.custom("Urbanist-Bold", size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        .padding(.leading, 10)
                    Spacer()
                }
                
                ScrollView {
                    
                    HStack {
                        Text("Introduction")
                            .font(.custom("Urbanist-Bold", size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    HStack {
                        
                        Text("Thanks for choosing Vooconnect \nAt Vooconnect, protecting your private information is our priority and we are committed to being upfront about it. Vooconnect respects the privacy needs and concerns of our customers. We appreciate the trust you place in us when you choose to visit our websites, make use of our App and Services and we take that responsibility seriously. This policy (“Privacy Policy”) is to inform you about what kinds of information we collect about you, including personally identifying information, how we use it, with whom it is shared and the choices you have regarding our use of that information. \nBy “personally identifying information”, we mean information that directly identifies you, such as your name, date of birth, IP address, device ID, credit/debit card information, telephone number, mailing address, or email address. In this Policy, “we” and “our” mean Vooconnect, and “you” or “your” mean any person who visits our website. To clarify, the given meaning of “Personal information” under this policy is in addition to the definition provided by the applicable law.")
                            .multilineTextAlignment(.leading)
                            .font(.custom("Urbanist-Regular", size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        
                    }
                    
                    HStack {
                        Text("Children Privacy")
                            .font(.custom("Urbanist-Bold", size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    HStack {
                        
                        Text("Our services are not intended for—and we don’t direct them to—anyone under 13. And that’s why we do not knowingly collect personal information from anyone under 13. If we need to rely on consent as a legal basis for processing your information, we may require your parent’s consent before we collect and use that information where permitted by applicable law.")
                            .multilineTextAlignment(.leading)
                            .font(.custom("Urbanist-Regular", size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        
                    }
                    
                    HStack {
                        Text("Data Collection")
                            .font(.custom("Urbanist-Bold", size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    HStack {
                        
                        Text("A. Information you Provide: Personal Data means any information which, either alone or in combination with other information we hold about you, identifies you as an individual, including, for example, your name, address, telephone number, email address, as well as any other non-public information about you that is associated with or linked to any of the foregoing data. Anonymous Data means data that is not associated with or linked to your Personal Data; Anonymous Data does not, by itself, permit the identification of individual persons. We collect Personal Data and Anonymous Data and a few other categories of information, from a few different sources, as described below.  We receive the information you provide to us when you: i) Create an account with us to log into our App and website, We may collect certain Personal Date from you, such as your first and last name, email, mailing address, payment information such as your credit card numbers for making purchases and phone number);")
                            .multilineTextAlignment(.leading)
                            .font(.custom("Urbanist-Regular", size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                        
                    }
                    
                    
                }
                
                
            }
            
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
