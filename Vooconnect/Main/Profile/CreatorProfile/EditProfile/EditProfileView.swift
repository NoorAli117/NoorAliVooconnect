//
//  EditProfileView.swift
//  Vooconnect
//
//  Created by Online Developer on 11/03/2023.
//

import SwiftUI
import Swinject

struct EditProfileView: View {
    @StateObject var editProfileViewModel = EditProfileViewModel()
    @State private var presentImagePicker = false
    private var userAuthanticationManager = Container.default.resolver.resolve(UserAuthenticationManager.self)!
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 24){
                EditProfileNavBar()
                
                ScrollView(showsIndicators: false){
                    
                    VStack(spacing: 24){
                        EditProfileImageView(editProfileViewModel: editProfileViewModel)
                            .padding(.top, 33)
                        
                        Divider()
                        
                        Heading(title: "About You")
                        ForEach(EditProfileRowType.aboutCases, id:\.self){ type in
                            EditProfileRow(editProfileViewModel: editProfileViewModel, rowType: type, value: getRowValue(type: type))
                        }
                        
                        Divider()
                        
                        Heading(title: "Social")
                        ForEach(EditProfileRowType.socialCases, id:\.self){ type in
                            EditProfileRow(editProfileViewModel: editProfileViewModel, rowType: type, value: getRowValue(type: type))
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 24)
            
            if editProfileViewModel.isUpdating{
                FullScreenProgressView()
            }
        }
        .navigationBarHidden(true)
        .actionSheet(isPresented: $editProfileViewModel.presentActionSheet, content: {
            getActionSheet()
        })
        .sheet(isPresented: $presentImagePicker) {
            ImagePicker(imageSelected: $editProfileViewModel.selectedProfilePhoto, sourceType: $editProfileViewModel.sourceType){
                editProfileViewModel.isProfilePhotoSelected = true
                editProfileViewModel.updateUserProfile()
            }
            
        }
        .alert(isPresented: $editProfileViewModel.isPresentAlert) {
            Alert(title: Text("Error"), message: Text(editProfileViewModel.errorString), dismissButton: .default(Text("Got it!")))
        }
    }
    
    
    private func getActionSheet() -> ActionSheet {
        
        let chooseFromGallery: ActionSheet.Button = .default(Text("Choose from Gallery")) {
            editProfileViewModel.sourceType = .photoLibrary
            presentImagePicker.toggle()
        }
        
        let capturePhoto: ActionSheet.Button = .default(Text("Capture Photo")) {
            editProfileViewModel.sourceType = .camera
            presentImagePicker.toggle()
        }
        let cancleButton: ActionSheet.Button = .cancel()
        let title = Text("what would you like to do")
        
        return ActionSheet(
            title: title,
            message: nil,
            buttons: [chooseFromGallery, capturePhoto, cancleButton]
        )
    }
}

extension EditProfileView{
    func getRowValue(type: EditProfileRowType) -> String{
        let userDetail = userAuthanticationManager.userDetail
        switch type {
        case .firstName:
            return userDetail?.firstName ?? ""
        case .lastName:
            return userDetail?.lastName ?? ""
        case .username:
            return userDetail?.username ?? ""
        case .bio:
            return userDetail?.bio ?? ""
        case .instagram:
            return userDetail?.instagram ?? ""
        case .facebook:
            return userDetail?.facebook ?? ""
        case .twitter:
            return userDetail?.twitter ?? ""
        default:
            return ""
        }
    }
    
    func Heading(title: String) -> some View{
        HStack{
            Text(title)
                .font(.urbanist(name: .urbanistBold, size: 20))
            Spacer()
        }
    }
}
