//
//  FillYourProfileView.swift
//  Vooconnect
//
//  Created by Vooconnect on 14/11/22.
//

import SwiftUI
import CountryPicker

struct FillYourProfileView: View {
    
    @State private var country: Country?
    @State private var showCountryPicker = false
    
    @Environment(\.presentationMode) var presentaionMode
    
    private let uploadImage: UploadProfileImageResource = UploadProfileImageResource()
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    
    private enum Field: Int, CaseIterable {
            case otp, shares
        }
    
    @State var selectedImage: UIImage = UIImage(named: "profileicon")!
    @State var showImagePicker: Bool = false
    @State var showPostImageView: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showActionSheet: Bool = false
    @State var actionSheetOption: ActionsheetOptions = .myProfile// Image shown on this screen
    
    @StateObject var fillProfileVM = FillYourProfileViewModel()
    
    enum ActionsheetOptions {
        case myProfile
    }
    
    @FocusState private var focusedField: Field?
    @FocusState private var focused: Bool
    @State private var pinView: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(.white)
                    .ignoresSafeArea()
                
                VStack {
                    
                    NavigationLink(destination: CreateNewPinView()
                        .navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $pinView) {
                            EmptyView()
                        }
                    
                    HStack {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Image("BackButton")
                        }
                        
                        Text("Fill Your Profile")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1726317704, green: 0.1726317704, blue: 0.1726317704, alpha: 1)))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    
                    ScrollView {
                        
                        VStack {
                            
                            Image(uiImage: selectedImage)
                                .resizable()
                                .frame(width: 140, height: 140)
                                .cornerRadius(29)
                                .overlay(
                                    Image("EditSquare")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .offset(x: 52, y: 52)
                                    
                                        .onTapGesture {
                                            actionSheetOption = .myProfile
                                            showActionSheet.toggle()
                                        }
                                    
                                )
                                .padding(.top, 25)
                                .padding(.bottom)
                            
                                .actionSheet(isPresented: $showActionSheet) {
                                    getActionSheet()
                                }
                            
                                .sheet(isPresented: $showImagePicker) {
                                    ImagePicker(imageSelected: $selectedImage, sourceType: $sourceType)
                                    
                                }
                            
                            
                            CustomeTextFieldThree(text: $fillProfileVM.fillYourDataModel.firstName, placeholder: "First Name", color: $fillProfileVM.fillYourDataModel.errorFirstName)
                                .focused($focusedField, equals: .otp)
                                .padding(.bottom)
                            
                            HStack {
                                Text(fillProfileVM.fillYourDataModel.firstNameError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                            CustomeTextFieldThree(text: $fillProfileVM.fillYourDataModel.lastName, placeholder: "Last Name", color: $fillProfileVM.fillYourDataModel.errorLastName)
                                .focused($focusedField, equals: .otp)
                                .padding(.bottom)
                            
                            HStack {
                                Text(fillProfileVM.fillYourDataModel.lastNameError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                            CustomeTextFieldThree(text: $fillProfileVM.fillYourDataModel.userName, placeholder: "Username", color: $fillProfileVM.fillYourDataModel.errorUserName)
                                .focused($focusedField, equals: .otp)
                                .padding(.bottom)
                            
                            HStack {
                                Text(fillProfileVM.fillYourDataModel.userNameError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                        }
                        
                        VStack {
                            
                            CustomeTextFieldThree(text: $fillProfileVM.fillYourDataModel.email, placeholder: "Email", color: $fillProfileVM.fillYourDataModel.errorEmail, icon: "Massage")
                                .focused($focusedField, equals: .otp)
                                .padding(.bottom)
                            
                            HStack {
                                Text(fillProfileVM.fillYourDataModel.emailError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                            VStack {
                                
                                ZStack {
                                    
                                    HStack {
                                        
                                        Button {
                                            showCountryPicker = true
                                        } label: {
                                            HStack {
                                                
                                                Text(country?.isoCode.getFlag() ?? "US".getFlag())
                                                    .font(.system(size: 30))
                                                    .frame(width: 25, height: 19)
                                                
                                                Image("DownArrow")
                                            }
                                        }
                                        .sheet(isPresented: $showCountryPicker) {
                                            CountryPicker(country: $country)
                                        }
                                        Text("+\(country?.phoneCode ?? "1")")
                                            .foregroundColor(.black)
                                        
                                        CustomTextFieldTwo(text: $fillProfileVM.fillYourDataModel.phone, placeholder: "")
                                            .focused($focusedField, equals: .otp)
                                            .focused($focused)
                                            .keyboardType(.numberPad)
                                            .foregroundColor(.black)
                                            .accentColor(.black)
                                        
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.vertical)
                                .background(focused ? Color(#colorLiteral(red: 0.9566952586, green: 0.925486505, blue: 1, alpha: 1)) : Color("txtFieldBackgroun"))
                                .cornerRadius(10)
                                
                                .overlay(focused ? RoundedRectangle(cornerRadius: 10).stroke(fillProfileVM.fillYourDataModel.errorPhone ? Color(.red) : Color("buttionGradientOne"), lineWidth: 2).cornerRadius(10) : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: fillProfileVM.fillYourDataModel.errorPhone ? 2 : 0).cornerRadius(10))
                                
                            }
                            .padding(.bottom)
                            
                            HStack {
                                Text(fillProfileVM.fillYourDataModel.phoneError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                            .toolbar(content: {
                                ToolbarItem(placement: .keyboard) {
                                    Spacer()
                                }
                                ToolbarItem(placement: .keyboard) {
                                    Button("Done") {
                                        focusedField = nil
                                    }
                                }
                            })
                            
                            CustomeTextFieldFour(text: $fillProfileVM.fillYourDataModel.address, placeholder: "Address", color: $fillProfileVM.fillYourDataModel.errorAddress, icon: "Location")
                                .focused($focusedField, equals: .otp)
                                .padding(.bottom)
                            
                            HStack {
                                Text(fillProfileVM.fillYourDataModel.addressError)
                                    .font(.custom("Urbanist-Regular", size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491002738, blue: 0, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .padding(.top, -10)
                            }
                            
                            HStack {
                                Button {
                                    pinView.toggle()
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
                                    
                                    fillProfileVM.fillYourDataModel.phoneCode = ("+\(country?.phoneCode ?? "1")")
                                    
                                    if(fillProfileVM.validationUserProfileData()) {
                                                                                
                                        fillProfileVM.fillYourDataModel.userNameError = ""
                                        fillProfileVM.fillYourDataModel.errorUserName = false
                                        
                                        fillProfileVM.fillYourDataModel.emailError = ""
                                        fillProfileVM.fillYourDataModel.errorEmail = false
                                        
                                        fillProfileVM.fillYourDataModel.phoneError = ""
                                        fillProfileVM.fillYourDataModel.errorPhone = false
                                        
                                        fillProfileVM.fillYourDataModel.progressView = true
                                        
                                        fillProfileVM.fillYourDataModel.addressError = ""
                                        fillProfileVM.fillYourDataModel.errorAddress = false
                                        
                                        uploadImageee(complitionHandler: { isSuccess in
                                            
                                            if isSuccess {
                                                fillProfileVM.upDateProfileApi()
                                            } else {
                                                debugPrint("Failed api will not hit")
                                            }
                                            
                                        })
                                        
                                        
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
                                
                                
                            }
                            .padding(.top, 40)
                            
                        }
                    }                    
                    
                    
                }
                .padding(.horizontal)
                
                if fillProfileVM.fillYourDataModel.progressView {
                    ProgressView()
                        .frame(width: 40,height: 40)
                }
                
            }
            
            .navigationBarHidden(true)
        }
        
        .alert(isPresented: $fillProfileVM.fillYourDataModel.isPresentingSuccess, content: {
            Alert(title: Text("Alert"), message: Text(fillProfileVM.fillYourDataModel.successMessage), dismissButton: .default(Text("Ok"), action: {
                pinView.toggle()
            }))
        })
        
        
        
        .onAppear {
            
            let userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
            let userPhone = UserDefaults.standard.string(forKey: "userPhone") ?? ""
            
            fillProfileVM.fillYourDataModel.email = userEmail
            fillProfileVM.fillYourDataModel.phone = userPhone
            
        }
        
        
    }
    
    
    
    private func uploadImageee(complitionHandler : @escaping(Bool) -> Void) {
        
        //        var compression: CGFloat = 1.0 // Loops down by 0.05
        //        let maxFileSize: Int = 240 * 240 // Maximum file size that we want to save
        //        let maxCompression: CGFloat = 0.05 // Maximum compression we ever allow
        
        // change
        
//        let imgPng: Data = selectedImage.jpegData(compressionQuality: 0.50) ?? Data()
//        print("the image", type(of: imgPng))
//        let bcf = ByteCountFormatter()
//        bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
//        bcf.countStyle = .file
//        let string = bcf.string(fromByteCount: Int64(imgPng.count))
//        print("The image size==================", string)
//
//
//
//        //            let imgPng = selectedImage.pngData()!
//        //                let imageStr: String = imageData.base64EncodedString()
//
////        let requset = UploadImageRequest(profile_image: imgPng)
//        let requset = UploadImageRequest(asset: imgPng, upload_path: "profile")
        
        // change
        
        let profileImage: UIImage = self.selectedImage
        let imageData: Data = profileImage.jpegData(compressionQuality: 0.1) ?? Data()
        let imageString: String = imageData.base64EncodedString()
        let paramStr: String = "profileImage=\(imageString)"
        let paramData: Data = paramStr.data(using: .utf8) ?? Data()
        
        
        uploadImage.uploadImage(imageUploadRequest: paramData, paramName: "asset", fileName: ".jpg") { responsee, errorMessage in
            DispatchQueue.main.async {
                if(responsee == true) {
                    print("Sucessss......")
                    complitionHandler(true)
                } else {
                    print("Errror.....")
                    complitionHandler(false)
                }
            }
        }
        
        
//        uploadImage.uploadImage(imageUploadRequest: selectedImage, paramName: "asset", fileName: "fs.png") { responsee, errorMessage in
//            DispatchQueue.main.async {
//                if(responsee == true) {
//                    print("Sucessss......")
//                    complitionHandler(true)
//                } else {
//                    print("Errror.....")
//                    complitionHandler(false)
//                }
//            }
//        }
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
//            myProfileVM.myProfileSubscribe()
//        }
        
    }
    
    private func getActionSheet() -> ActionSheet {
        
        let chooseFromGallery: ActionSheet.Button = .default(Text("Choose from Gallery")) {
            print("Choose from Gallery")
            sourceType = UIImagePickerController.SourceType.photoLibrary
            showImagePicker.toggle()
        }
        
        let capturePhoto: ActionSheet.Button = .default(Text("Capture Photo")) {
            print("Capture Photo")
            sourceType = UIImagePickerController.SourceType.camera
            showImagePicker.toggle()
        }
        let cancleButton: ActionSheet.Button = .cancel()
        let title = Text("what woud you like to do")
        
        switch actionSheetOption {
        case .myProfile:
            return ActionSheet(title: title,
                               message: nil,
                               buttons: [chooseFromGallery, capturePhoto, cancleButton])
        }
    }
    
}

struct FillYourProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FillYourProfileView()
    }
}
