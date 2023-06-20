//
//  CustomViews.swift
//  Messengel
//
//  Created by Saad on 4/30/21.
//

import SwiftUI
import NavigationStack
import PDFKit
import Kingfisher
import WrappingHStack
import UniformTypeIdentifiers

struct MyLink: View {
    var url = "https://www.google.com/"
    var text: String
    var fontSize: CGFloat = 13
    var body: some View {
        Link(destination: URL(string: url)!, label: {
            Text(text)
                .font(.system(size: fontSize))
                .underline()
        })
    }
}

// MARK: - Buttons

//struct NextButton: View {
//    var isCustomAction = false
//    var customAction: () -> Void = {}
//    var source: String?
//    var destination: AnyView?
//    var color = Color.white
//    var iconColor = appColor
//    var loading = false
//
//    @Binding var active: Bool
//    @EnvironmentObject private var navigationModel: NavigationModel
//
//    var body: some View {
//        Rectangle()
//            .foregroundColor(color)
//            .frame(width: 56, height: 56)
//            .cornerRadius(25)
//            .opacity(active ? 1 : 0.5)
//            .overlay(
//                Button(action: {
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                    if active && isCustomAction {
//                        customAction()
//                    } else if active, let source = source {
//                        navigationModel.pushContent(source) {
//                            destination
//                        }
//                    }
//                }) {
//                    if loading {
//                        Loader(tintColor: iconColor)
//                    } else {
//                        Image(systemName: "chevron.right").foregroundColor(iconColor)
//                    }
//                }
//            )
//    }
//}
//
//struct ContactsListButton: View {
//    var action: () -> Void
//    var body: some View {
//        HStack {
//            Button(action: {
//                action()
//            }, label: {
//                HStack {
//                    Image("ic_contacts")
//                        .renderingMode(.template)
//                        .foregroundColor(.white)
//                    Text("Liste des contacts")
//                }
//            })
//            .buttonStyle(MyButtonStyle(padding: 0.0, maxWidth: false, foregroundColor: .white, backgroundColor: appColor))
//            Spacer()
//        }
//    }
//}
//
//struct OrgListButton: View {
//    var action: () -> Void
//    var body: some View {
//        HStack {
//            Button(action: {
//                action()
//            }, label: {
//                HStack {
//                    Image("ic_orgs")
//                        .renderingMode(.template)
//                        .foregroundColor(.white)
//                    Text("Liste des organismes")
//                }
//            })
//            .buttonStyle(MyButtonStyle(padding: 0.0, maxWidth: false, foregroundColor: .white, backgroundColor: appColor))
//            Spacer()
//        }
//    }
//}

//struct SignupProgressView: View {
//    @Binding var progress: Double
//    var tintColor = Color.white
//    var progressMultiplier: Double
//
//    var body: some View {
//        Rectangle()
//            .foregroundColor(tintColor)
//            .frame(width: screenSize.width * (progress/100), height: 4.5)
//            .padding(.horizontal, -17)
//            .padding(.bottom, -17)
//    }
//}
//
//struct FlowProgressView: View {
//    @Binding var progress: Double
//    var tintColor = Color.white
//    var progressMultiplier: Double
//
//    var body: some View {
//        ProgressView(value: progress, total: 100.0)
//            .progressViewStyle(LinearProgressViewStyle(tint: tintColor))
//            .padding(.horizontal, -17)
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    withAnimation {
//                        progress += progressMultiplier
//                    }
//                }
//            }
//    }
//}

//struct CustomCorner: Shape {
//
//    var corners: UIRectCorner
//    var radius = 25.0
//
//    func path(in rect: CGRect) -> Path {
//
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//
//        return Path(path.cgPath)
//    }
//}
//
//var months = ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"]
//
//struct MyDatePickerView: View {
//    @Binding var day: Int
//    @Binding var month: String
//    @Binding var year: Int
//
//    var body: some View {
//        HStack {
//            Spacer().frame(width: 20)
//            Picker(selection: $day, label: HStack(alignment: .bottom) {
//                Image("updown")
//                Text("\(day)").font(.system(size: 20))
//            }) {
//                ForEach((1...31), id: \.self) {
//                    Text("\($0)")
//                }
//            }
//            Spacer()
//            Picker(selection: $month, label: HStack(alignment: .bottom) {
//                Image("updown")
//                Text("\(month)").font(.system(size: 20))
//            }) {
//                ForEach(months, id: \.self) {
//                    Text("\($0)")
//                }
//            }
//            Spacer()
//            Picker(selection: $year, label: HStack(alignment: .bottom) {
//                Image("updown")
//                Text(String(year)).font(.system(size: 20))
//            }) {
//                ForEach((1930...2010), id: \.self) {
//                    Text(String($0))
//                }
//            }
//            Spacer().frame(width: 20)
//        }
//        .padding().background(Color.white).cornerRadius(20).foregroundColor(.black).pickerStyle(MenuPickerStyle())
//    }
//}


//struct CustomTextField: UIViewRepresentable {
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//
//        @Binding var text: String
//        var didBecomeFirstResponder = false
//
//        init(text: Binding<String>) {
//            _text = text
//        }
//
//        func textFieldDidChangeSelection(_ textField: UITextField) {
//            text = textField.text ?? ""
//        }
//
//    }
//
//    @Binding var text: String
//    var isFirstResponder: Bool = false
//
//    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
//        let textField = UITextField(frame: .zero)
//        textField.delegate = context.coordinator
//        return textField
//    }
//
//    func makeCoordinator() -> CustomTextField.Coordinator {
//        return Coordinator(text: $text)
//    }
//
//    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
//        uiView.text = text
//        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
//            uiView.becomeFirstResponder()
//            context.coordinator.didBecomeFirstResponder = true
//        }
//    }
//}
//
//struct InputAlert: View {
//    @State private var inputText = ""
//    @FocusState private var isFocused: Bool
//    var title: String
//    var message: String
//    var placeholder = ""
//    var ok = "Valider"
//    var cancel = "Cancel"
//    var action: (String?) -> Void
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 22.0)
//            .foregroundColor(.white)
//            .frame(width: 270, height: 188)
//            .thinShadow()
//            .overlay(
//                VStack {
//                    Text(title)
//                        .font(.system(size: 17), weight: .semibold)
//                        .padding(.bottom, 5)
//                    Text(message)
//                        .font(.system(size: 13))
//                        .multilineTextAlignment(.center)
//                    //                    CocoaTextField(placeholder, text: $inputText)
//                    //                        .isInitialFirstResponder(true)
//                    //                        .borderStyle(.roundedRect)
//                    TextField(placeholder, text: $inputText)
//                        .focused($isFocused)
//                        .textFieldStyle(.roundedBorder)
//                        .padding(.bottom, 5)
//                    Divider()
//                        .padding(.horizontal, -15)
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            action(nil)
//                        }) {
//                            Text(cancel)
//                                .font(.system(size: 17))
//                                .foregroundColor(.black)
//                        }
//                        Spacer()
//                        Divider()
//                            .padding(.top, -3)
//                        Spacer()
//                        Button(action: {
//                            action(inputText)
//                        }) {
//                            Text(ok)
//                                .font(.system(size: 17), weight: .semibold)
//                                .foregroundColor(appColor)
//                        }
//                        Spacer()
//                    }
//                    .padding(.vertical, -5)
//                }
//                    .padding(.horizontal)
//                    .padding(.top, 25)
//            )
//            .onAppear() {
//                isFocused = true
//            }
//    }
//}
//struct InputAlertVideo: View {
//    @State private var inputText = ""
//    @FocusState private var isFocused: Bool
//    var title: String
//    var message: String
//    var placeholder = ""
//    var ok = "Valider"
//    var cancel = "Revenir"
//    var action: (String?) -> Void
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 22.0)
//            .foregroundColor(.white)
//            .frame(width: 270, height: 188)
//            .thinShadow()
//            .overlay(
//                VStack {
//                    Text(title)
//                        .font(.system(size: 17), weight: .semibold)
//                        .padding(.bottom, 5)
//                    Text(message)
//                        .font(.system(size: 13))
//                        .multilineTextAlignment(.center)
//                    //                    CocoaTextField(placeholder, text: $inputText)
//                    //                        .isInitialFirstResponder(true)
//                    //                        .borderStyle(.roundedRect)
//                    TextField(placeholder, text: $inputText)
//                        .focused($isFocused)
//                        .textFieldStyle(.roundedBorder)
//                        .padding(.bottom, 5)
//                    Divider()
//                        .padding(.horizontal, -15)
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            action(nil)
//                        }) {
//                            Text(cancel)
//                                .font(.system(size: 17))
//                                .foregroundColor(.black)
//                        }
//                        Spacer()
//                        Divider()
//                            .padding(.top, -3)
//                        Spacer()
//                        Button(action: {
//                            action(inputText)
//                        }) {
//                            Text(ok)
//                                .font(.system(size: 17), weight: .semibold)
//                                .foregroundColor(appColor)
//                        }
//                        Spacer()
//                    }
//                    .padding(.vertical, -5)
//                }
//                    .padding(.horizontal)
//                    .padding(.top, 25)
//            )
//            .onAppear() {
//                isFocused = true
//            }
//    }
//}
//
//struct MyAlert: View {
//    var title: String
//    var message: String
//    var ok = "Supprimer"
//    var cancel = "Annuler"
//    var height = 200.0
//    var action: () -> Void
//    @Binding var showAlert: Bool
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 22.0)
//            .foregroundColor(.white)
//            .frame(width: 270, height: height)
//            .thinShadow()
//            .overlay(
//                VStack {
//                    Text(title)
//                            .font(.system(size: 17), weight: .semibold)
//                            .isHidden(hidden: (title.isEmpty || title == "") ? true : false, remove: (title.isEmpty || title == "") ? true : false)
//                    Text(message)
//                        .font(.system(size: 13))
//                        .multilineTextAlignment(.center)
//                        .padding(.vertical, 5)
//                        .isHidden(hidden: (message.isEmpty || message == "") ? true : false,remove: (message.isEmpty || message == "") ? true : false)
//                    Divider()
//                        .padding(.horizontal, -15)
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            showAlert.toggle()
//                        }) {
//                            Text(cancel)
//                                .font(.system(size: 17))
//                                .foregroundColor(.black)
//                        }
//                        Spacer()
//                        Divider()
//                        Spacer()
//                        Button(action: {
//                            showAlert.toggle()
//                            action()
//                        }) {
//                            Text(ok)
//                                .font(.system(size: 17), weight: .semibold)
//                                .foregroundColor(appColor)
//                        }
//                        Spacer()
//                    }
//                    .frame(height: 30)
//                    .frame(maxWidth: .infinity)
//                }
//                    .padding(.horizontal)
//                    .padding(.top, 25)
//            )
//    }
//}
//
//struct MyAlertInfo: View {
//    var title: String
//    var message: String
//    var ok = "ok"
//    var height = 200.0
//    @Binding var showAlert: Bool
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 22.0)
//            .foregroundColor(.white)
//            .frame(width: 270, height: height)
//            .thinShadow()
//            .overlay(
//                VStack {
//                    if !title.isEmpty {
//                        Text(title)
//                            .font(.system(size: 17), weight: .semibold)
//                            .padding(.vertical, 5)
//                    }
//                    Text(message)
//                        .font(.system(size: 13))
//                        .multilineTextAlignment(.center)
//                    Divider()
//                        .padding(.horizontal, -15)
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            showAlert.toggle()
//                        }) {
//                            Text(ok)
//                                .font(.system(size: 17), weight: .semibold)
//                                .foregroundColor(appColor)
//                        }
//                        Spacer()
//                    }
//                    .frame(height: 44)
//                    //                    .padding(.vertical, -5)
//                }
//                    .padding(.horizontal)
//                    .padding(.top, 25)
//            )
//    }
//}
//
//struct ListItemView: View {
//    var name = ""
//    var image = "ic_company"
//    var action = {}
//
//    var body: some View {
//        Button {
//            action()
//        } label: {
//            Capsule()
//                .fill(Color.white)
//                .frame(height: 56)
//                .normalShadow()
//                .overlay(HStack{
//                    Image(image)
//                        .padding(.leading)
//                    Text(name)
//                        .foregroundColor(.black)
//                    Spacer()
//                    ZStack {
//                        Circle()
//                            .foregroundColor(appColor)
//                            .frame(width: 24, height: 24)
//                       Image("ic_plus")
//                            .renderingMode(.template)
//                            .foregroundColor(.white)
//                    }
//                    .padding(.trailing)
//                })
//                .padding(.bottom)
//        }
//
//    }
//}
//
//struct ChoiceCard: View {
//    var text: String
//    @Binding var selected: Bool
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 22)
//            .foregroundColor(.white)
//            .frame(width: 160, height: 160)
//            .normalShadow()
//            .overlay(
//                VStack {
//                    Spacer().frame(height: 50)
//                    ZStack {
//                        Circle()
//                            .fill(Color.white)
//                            .frame(width: 26, height: 26)
//                            .thinShadow()
//                        Circle()
//                            .fill(selected ? appColor : Color.gray)
//                            .frame(width: 18, height: 18)
//                    }
//                    Text(text)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal)
//                    Spacer()
//                }
//            )
//    }
//}
//
//struct FlowChoicesView<VM: CUViewModel>: View {
//    @State var showNote = false
//    var tab = 0
//    var stepNumber: Double
//    var totalSteps: Double
//    @Binding var noteText: String
//    @Binding var noteAttachmentIds: [Int]?
//    @Binding var oldAttachedFiles: [URL]?
//    var choices: [FuneralChoice]
//    @Binding var selectedChoice: Int?
//    var menuTitle: String
//    var title: String
//    var destination: AnyView
//    @ObservedObject var vm: VM
//    @Binding var loading: Bool
//
//    var body: some View {
//        ZStack {
//            if showNote {
//                NoteWithAttachementView(showNote: $showNote, note: $noteText, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
//                 .zIndex(1.0)
//                 .background(.black.opacity(0.8))
//            }
//            WishesFlowBaseView(tab: tab, stepNumber: stepNumber, totalSteps: totalSteps, noteText: $noteText, note: true, showNote: $showNote, menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination, viewModel: vm) {
//                if !loading {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(){
//                        ForEach(choices, id: \.self) { choice in
//                            VStack(spacing: 0) {
//                                Color.white
//                                    .frame(width: 161.0, height: 207.52)
//                                    .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
//                                    .overlay(
//                                        KFImage.url(URL(string: choice.image))
//                                            .placeholder {
//                                                Loader()
//                                            }
//                                            .resizable()
//                                            .frame(width: 161.0, height: 207.52)
//                                            .scaledToFill()
//                                            .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
//                                    )
//                                Rectangle()
//                                    .foregroundColor(selectedChoice == choice.id ? appColor : .white)
//                                    .frame(width: 161, height: 44)
//                                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
//                                    .overlay(
//                                        Text(choice.name)
//                                            .foregroundColor(selectedChoice == choice.id ? .white : .black)
//                                    )
//                                    .padding(.top, -7)
//                            }
//                            .thinShadow()
//                            .onTapGesture {
//                                if selectedChoice == choice.id {
//                                    selectedChoice = nil
//                                } else {
//                                    selectedChoice = choice.id
//                                }
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal, 0)
//                } else {
//                    Loader()
//                }
//            }
//        }
//    }
//}
//
//struct FlowMultipleChoicesView<VM: CUViewModel>: View {
//    @State var showNote = false
//    var tab = 0
//    var stepNumber: Double
//    var totalSteps: Double
//    @Binding var noteText: String
//    @Binding var noteAttachmentIds: [Int]?
//    @Binding var oldAttachedFiles: [URL]?
//    var choices: [FuneralChoice]
//    @Binding var selectedChoice: [Int]
//    var menuTitle: String
//    var title: String
//    var destination: AnyView
//    @ObservedObject var vm: VM
//    @Binding var loading: Bool
//
//    var body: some View {
//        ZStack {
//            if showNote {
//                NoteWithAttachementView(showNote: $showNote, note: $noteText, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
//                 .zIndex(1.0)
//                 .background(.black.opacity(0.8))
//            }
//            WishesFlowBaseView(tab: tab, stepNumber: stepNumber, totalSteps: totalSteps, noteText: $noteText, note: true, showNote: $showNote, menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination, viewModel: vm) {
//                if !loading {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(choices, id: \.self) { choice in
//                                VStack(spacing: 0) {
//                                    Color.white
//                                        .frame(width: 161.0, height: 207.52)
//                                        .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
//                                        .overlay(
//                                            KFImage.url(URL(string: choice.image))
//                                                .placeholder {
//                                                    Loader()
//                                                }
//                                                .resizable()
//                                                .frame(width: 161.0, height: 207.52)
//                                                .scaledToFill()
//                                                .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
//                                        )
//                                    Rectangle()
//                                        .foregroundColor(selectedChoice.contains(choice.id) ? appColor : .white)
//                                        .frame(width: 161, height: 44)
//                                        .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
//                                        .overlay(
//                                            Text(choice.name)
//                                                .foregroundColor(selectedChoice.contains(choice.id) ? .white : .black)
//                                        )
//                                        .padding(.top, -7)
//                                }
//                                .thinShadow()
//                                .onTapGesture {
//                                    if selectedChoice.contains(choice.id) {
//                                        selectedChoice.removeAll(where: {$0 == choice.id})
//                                    } else {
//                                        selectedChoice.append(choice.id)
//                                    }
//                                }
//                            }
//                        }
//                        .padding()
//                    }
//                    .padding(.horizontal, -16)
//                } else {
//                    Loader()
//                }
//            }
//        }
//    }
//}

// MARK: - Custom Note Views

//struct NoteView: View {
//    @Binding var showNote: Bool
//    @Binding var note: String
//
//    var body: some View {
//        VStack(spacing: 0.0) {
//            Rectangle()
//                .fill(Color.gray.opacity(0.2))
//                .frame(width: 161, height: 207.52)
//                .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .fill(note.isEmpty ? Color.gray : appColor)
//                        .frame(width: 56, height: 56)
//                        .overlay(
//                            Button(action: {
//                                showNote.toggle()
//                            }) {
//                                Image(note.isEmpty ? "ic_add_note" : "ic_notes")
//                            }
//                        )
//                )
//            Rectangle()
//                .fill(Color.white)
//                .frame(width: 161, height: 44)
//                .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
//                .overlay(Text("Note"))
//        }
//        .thinShadow()
//    }
//}
//
//struct NoteWithAttachementView: View {
//    @Binding var showNote: Bool
//    @Binding var note:String
//    @Binding var oldAttachedFiles: [URL]?
//    @Binding var noteAttachmentIds: [Int]?
////    @State var expandedNote = false
//    @State var loading = false
//    @State var showExitAlert = false
////    @FocusState private var isFocused: Bool
//    @State private var attachements = [Attachment]()
//    @State private var showFileImporter = false
//    @State private var attachedFiles = [URL]()
//    @State private var selectedFile = URL(string: "")
//    @State private var deleteNote = false
//    @State private var deleteAttac = false
//
//    var multiple = true
//
//    var body: some View {
//        ScrollView {
//            ZStack {
//                if deleteNote {
//                    Color.black.opacity(0.8)
//                        .ignoresSafeArea()
//                        .overlay(MyAlert(title: "Supprimer cette Note ?", message: "Cette note les piéces-jointes seront supprimées de votre Messangel.", ok: "Oui",
//                                         height: 200, action: {
//                            note.removeAll()
//                            attachements.removeAll()
//                            noteAttachmentIds?.removeAll()
//                            attachedFiles.removeAll()
//                            oldAttachedFiles?.removeAll()
//                            showNote.toggle()
//                        }, showAlert: $deleteNote))
//                        .zIndex(10.0)
//                }
//
//                if deleteAttac {
//                    Color.black.opacity(0.8)
//                        .ignoresSafeArea()
//                        .overlay(MyAlert(title: "Supprimer cette piéce-jointe ?", message: "Cette piéce-jointe sera supprimée de votre Messangel", ok: "Oui",
//                                         height: 200, action: {
//                            attachedFiles.remove(at: attachedFiles.firstIndex(of: selectedFile!)!)
//                        }, showAlert: $deleteAttac))
//                        .zIndex(20.0)
//                }
//
//                VStack(spacing: 20) {
//                    Spacer().frame(height: 50)
//                    HStack {
//                        Button(action: {
//    //                        showExitAlert.toggle()
//                            showNote.toggle()
//                        }, label: {
//                            Image("ic_close_note")
//                        })
//                        Spacer()
//                        Button(action: {
//                            deleteNote = true
//                        }) {
//                            Image("ic_del")
//                        }
//                    }
//    //                Spacer()
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .foregroundColor(.white)
//                        .frame(height: 56)
//                        .overlay(
//                            HStack {
//                                Image("ic_note")
//                                Text("Note")
//                                    .font(.system(size: 17), weight: .semibold)
//                                    .foregroundColor(.black)
//                                Spacer()
//                                Button(action: {
////                                    isFocused = false
//                                    showFileImporter.toggle()
//                                }, label: {
//                                    HStack {
//                                        Image("ic_attachement")
////                                        Text("Joindre un fichier")
//                                            .foregroundColor(.gray)
////                                            .underline()
//                                    }
//                                })
//                            }
//                                .padding(.horizontal)
//                        )
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .foregroundColor(.white)
//                        .frame(height: 290)
//                        .overlay(
//                            VStack {
//                                ZStack(alignment: .topLeading){
//                                    TextEditor(text: $note)
//                                    if note.isEmpty {
//                                        Text("Saisissez votre texte")
//                                            .foregroundColor(Color(.placeholderText))
//                                            .font(.system(size: 20))
//                                            .padding(.top,6)
//                                            .padding(.leading, 4)
//                                    }
//                                }
//
//    //                                .focused($isFocused)
//                                HStack {
////                                    Button(action: {
////    //                                    isFocused = false
////                                        showFileImporter.toggle()
////                                    }, label: {
////                                        HStack {
////                                            Image("ic_attachement")
////                                            Text("Joindre un fichier")
////                                                .foregroundColor(.gray)
////                                                .underline()
////                                        }
////                                    })
//                                    Spacer()
//                                    Button(action: {
//                                        Task {
//                                            loading.toggle()
//                                            if !attachedFiles.isEmpty && (attachements.isEmpty || attachedFiles != oldAttachedFiles) {
//                                                attachements.removeAll()
//                                                let uploadedFiles = await uploadFiles(attachedFiles)
//                                                for uploadedFile in uploadedFiles {
//                                                    attachements.append(Attachment(url: uploadedFile))
//                                                }
//                                                APIService.shared.post(model: attachements, response: attachements, endpoint: "users/note_attachment") { result in
//                                                    switch result {
//                                                    case .success(let attachements):
//                                                        DispatchQueue.main.async {
//                                                            self.attachements = attachements
//                                                            var attachementIds = [Int]()
//                                                            for attachement in self.attachements {
//                                                                if let id = attachement.id {
//                                                                    attachementIds.append(id)
//                                                                }
//                                                            }
//                                                            noteAttachmentIds = attachementIds
//                                                            loading.toggle()
//                                                            showNote.toggle()
//                                                        }
//                                                    case .failure(let error):
//                                                        DispatchQueue.main.async {
//                                                            print(error.error_description)
//                                                            loading.toggle()
//                                                            showNote.toggle()
//                                                        }
//                                                    }
//                                                }
//                                            } else {
//                                                loading.toggle()
//                                                showNote.toggle()
//                                            }
//                                        }
//                                    }, label: {
//                                        Image("ic_save_note")
//                                    })
//                                }
//                            }
//                                .padding(.horizontal)
//                                .padding(.vertical, 20)
//                        )
//                    if !attachedFiles.isEmpty {
//                        WrappingHStack()  {
//                            ScrollView(.horizontal){
//                                HStack{
//                                    ForEach(attachedFiles, id: \.self) { file in
//                                        FuneralCapsuleView(name: file.lastPathComponent) {
//                                            selectedFile = file
//                                            deleteAttac = true
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        .frame(maxWidth: 400)
//    //                    .padding(.horizontal)
//                    }
//                    Spacer().frame(height: 50)
//                }
//                .padding()
//                .onAppear() {
//    //                if oldAttachedFiles == nil {
//    //                    isFocused = true
//    //                }
//
//                    if let oldAttachedFiles = oldAttachedFiles {
//                        self.attachedFiles = oldAttachedFiles
//                    }
//                }
//                .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.pdf, .jpeg], allowsMultipleSelection: multiple) { result in
//                    switch result {
//                    case .success(let fileUrl):
//                        fileUrl.forEach { url in
//                            self.attachedFiles.append(url)
//                            self.oldAttachedFiles = self.attachedFiles
//                        }
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
//                if loading {
//                    UpdatingView(text: "Note enregistrée")
//                }
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged {_ in
//                        hideKeyboard()
//                    }
//            )
//        }
//    }
//}
//
//struct DetailsNoteView: View {
//    @EnvironmentObject private var navigationModel: NavigationModel
//    var note: String
//    var attachments: [Attachement]?
//    var navId = ""
//    var body: some View {
//        VStack {
//            if !note.trimmingCharacters(in: .whitespaces).isEmpty {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .foregroundColor(.gray.opacity(0.2))
//                        .frame(maxHeight: .infinity)
//                    VStack(alignment: .leading) {
//                        HStack{
//                            Image("ic_note")
//                            Text("Note")
//                                .font(.system(size: 15), weight: .bold)
//                            Spacer()
//                        }
//                        Text(note)
//                        if let attachments = attachments, !attachments.isEmpty {
//                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))], alignment: .leading, spacing: 16.0) {
//                                ForEach(attachments, id: \.self) { file in
//                                    FuneralCapsuleView(trailingButton: false, name: URL(string: file.url)?.lastPathComponent ?? "") {}
//                                    .onTapGesture(count: 2) {}
//                                    .onTapGesture(count: 1) {
//                                        if let fileUrl = URL(string: file.url), !navId.isEmpty {
//                                            navigationModel.presentContent(navId) {
//                                                if fileUrl.pathExtension == "pdf" {
//                                                    VStack {
//                                                        HStack {
//                                                            BackButton(iconColor: appColor)
//                                                                .padding(.leading)
//                                                            Spacer()
//                                                        }
//                                                        PDFKitRepresentedView(fileUrl)
//                                                    }
//                                                } else {
//                                                    VStack {
//                                                        HStack {
//                                                            BackButton(iconColor: appColor)
//                                                                .padding(.leading)
//                                                            Spacer()
//                                                        }
//                                                        AsyncImage(url: fileUrl) { image in
//                                                            image.resizable()
//                                                        } placeholder: {
//                                                            Loader()
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                    }
//                    .padding()
//                }
//                .fixedSize(horizontal: false, vertical: true)
//                .padding(.top, 30)
//            }
//        }
//    }
//}

//struct FuneralNote: View {
//    @Binding var showNote: Bool
//    @Binding var note:String
//    @State var expandedNote = false
//    @FocusState private var isFocused: Bool
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Spacer().frame(height: 50)
//            HStack {
//                Button(action: {
//                    showNote.toggle()
//                }, label: {
//                    Image("ic_close_note")
//                })
//                Spacer()
//            }
//            Spacer()
//            RoundedRectangle(cornerRadius: 25.0)
//                .foregroundColor(.gray)
//                .frame(height: 56)
//                .overlay(
//                    HStack {
//                        Image("ic_notes")
//                        Text("Notes")
//                            .font(.system(size: 17), weight: .semibold)
//                            .foregroundColor(.white)
//                        Spacer()
//                        Button(action: {
//                            expandedNote.toggle()
//                        }, label: {
//                            Image("ic_expand_notes")
//                        })
//                    }
//                    .padding(.horizontal)
//                )
//            RoundedRectangle(cornerRadius: 25.0)
//                .foregroundColor(.white)
//                .frame(height: expandedNote ? 295 : 160)
//                .overlay(
//                    VStack {
//                        TextEditor(text: $note)
//                            .focused($isFocused)
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                showNote.toggle()
//                            }, label: {
//                                Image("ic_save_note")
//                            })
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.vertical, 20)
//                )
//            Spacer()
//        }
//        .padding()
//        .onAppear() {
//            isFocused = true
//        }
//    }
//
//}
//struct FuneralNoteView<VM: CUViewModel>: View {
//    var tab = 0
//    var stepNumber: Double
//    var totalSteps: Double
//    @Binding var showNote: Bool
//    @Binding var note: String
//    @Binding var noteAttachmentIds: [Int]?
//    @Binding var oldAttachedFiles: [URL]?
//    var menuTitle: String
//    var title: String
//    var destination: AnyView
//    @ObservedObject var vm: VM
//
//    var body: some View {
//        ZStack {
//            if showNote {
//                NoteWithAttachementView(showNote: $showNote, note: $note, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
//                    .zIndex(1.0)
//                    .background(.black.opacity(0.8))
//            }
//            WishesFlowBaseView(tab: tab, stepNumber: stepNumber, totalSteps: totalSteps, note: false, showNote: .constant(false),menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination, viewModel: vm) {
//              NoteView(showNote: $showNote, note: $note)
//            }
//        }
//    }
//}
//
//struct FuneralNoteAttachCutomActionView<VM: CUViewModel>: View {
//    var tab = 0
//    var stepNumber: Double
//    var totalSteps: Double
//    @Binding var showNote: Bool
//    @Binding var note: String
//    @Binding var loading: Bool
//    @Binding var oldAttachedFiles: [URL]?
//    @Binding var noteAttachmentIds: [Int]?
//    var menuTitle: String
//    var title: String
//    @ObservedObject var vm: VM
//    var customAction: () -> Void
//
//    var body: some View {
//        ZStack {
//            if showNote {
//                NoteWithAttachementView(showNote: $showNote, note: $note, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
//                    .zIndex(1.0)
//                    .background(.black.opacity(0.8))
//            }
//            WishesFlowBaseView(tab: tab, stepNumber: stepNumber, totalSteps: totalSteps, isCustomAction: true, customAction: customAction, note: false, showNote: .constant(false), menuTitle: menuTitle, title: title, valid: .constant(true), viewModel: vm) {
//                NoteView(showNote: $showNote, note: $note)
//                if loading {
//                    Loader()
//                        .padding(.top)
//                }
//            }
//        }
//    }
//}
//
//struct FuneralCapsuleView: View {
//    var trailingButton = true
//    var name: String
//    var action: () -> Void
//
//    var body: some View {
//        HStack {
//            ZStack {
//                RoundedRectangle(cornerRadius: 25.0)
//                    .frame(height: 56)
//                    .foregroundColor(.white)
//                    .thinShadow()
//                HStack(spacing: 20) {
//                    Text(name)
//                        .font(.system(size: 14))
//                        .maxWidth(300)
//                    if trailingButton {
//                        Button(action: {
//                            action()
//                        }, label: {
//                            ZStack {
//                                Circle()
//                                    .frame(width: 24, height: 24)
//                                    .foregroundColor(.white)
//                                Image("ic_remove")
//                            }
//                        })
//                            .thinShadow()
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .fixedSize()
//            Spacer()
//        }
//    }
//}
//
//// MARK: - PDF
//
//struct PDFKitRepresentedView: UIViewRepresentable {
//    let url: URL
//
//    init(_ url: URL) {
//        self.url = url
//    }
//
//    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
//        // Create a `PDFView` and set its `PDFDocument`.
//        let pdfView = PDFView()
//        pdfView.document = PDFDocument(url: self.url)
//        return pdfView
//    }
//
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
//        // Update the view.
//    }
//}
//
////MARK: - Image Views
//struct ProfileImageView: View {
//    var imageUrlString: String?
//    var imageSize = 66.0
//    var cornerRadius = 28.0
//    var body: some View {
//        if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
//            KFImage.url(imageUrl)
//                .placeholder {
//                    Loader()
//                }
//                .resizable()
//                .scaledToFill()
//                .frame(width: imageSize, height: imageSize)
//                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
//        }
//    }
//}
//
//struct ImageSelectionView: View {
//    @State private var showImagePicker: Bool = false
//    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
//    @Binding var showImagePickerOptions: Bool
//    @Binding var localImage: UIImage
//    var remoteImage: String
//    var imageSize = 66.0
//    var title = "Ajouter une photo"
//    var underlineTitle = true
//    var isShowCameraIcon = false
//    var cornerRadius = 24.0
//    var fromMessage = false
//    var body: some View {
//        Button {
//            showImagePickerOptions.toggle()
//        } label: {
//            if remoteImage.isEmpty && localImage.cgImage == nil {
//                VStack {
//                    Rectangle()
//                        .fill(appColor)
//                        .frame(width: imageSize, height: imageSize)
//                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
//                        .overlay(fromMessage ? Image("ic_camera_plus") : Image("ic_camera"))
//                        .overlay(alignment: .bottomTrailing) {
//                            if isShowCameraIcon {
//                                Rectangle()
//                                    .fill(appColor)
//                                    .frame(width: 40, height: 40)
//                                    .clipShape(RoundedRectangle(cornerRadius: 30))
//                                    .overlay((fromMessage ? Image("ic_camera_plus") : Image("ic_camera"))
//                                        .onTapGesture {
//                                            showImagePickerOptions.toggle()
//                                        })
//                            }
//                        }
//                    if isShowCameraIcon == false {
//                        Text(title)
//                            .foregroundColor(appColor)
//                            .if (underlineTitle) { $0.underline() }
//                    }
//                }
//            } else if localImage.cgImage != nil {
//                VStack {
//                    Image(uiImage: localImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: imageSize, height: imageSize)
//                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
//                        .overlay(alignment: .bottomTrailing) {
//                            if isShowCameraIcon {
//                                Rectangle()
//                                    .fill(appColor)
//                                    .frame(width: 40, height: 40)
//                                    .clipShape(RoundedRectangle(cornerRadius: 30))
//                                    .overlay((fromMessage ? Image("ic_camera_plus") : Image("ic_camera"))
//                                        .onTapGesture {
//                                            showImagePickerOptions.toggle()
//                                        })
//                            }
//                        }
//                    if isShowCameraIcon == false {
//                        Text(title)
//                            .foregroundColor(appColor)
//                            .if (underlineTitle) { $0.underline() }
//                    }
//                }
////                    .overlay(alignment: .bottomTrailing) {
////                        Rectangle()
////                            .fill(appColor)
////                            .frame(width: 40, height: 40)
////                            .clipShape(RoundedRectangle(cornerRadius: 30))
////                            .overlay(Image("ic_camera")
////                                .onTapGesture {
////                                    showImagePickerOptions.toggle()
////                                })
////                    }
//            } else if !remoteImage.isEmpty {
//                VStack {
//                    KFImage.url(URL(string: remoteImage))
//                        .placeholder {
//                            Rectangle()
//                                .fill(appColor)
//                                .frame(width: imageSize, height: imageSize)
//                                .clipShape(Circle())
//                                .overlay(Loader(tintColor: .white))
//                        }
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: imageSize, height: imageSize)
//                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
//                        .overlay(alignment: .bottomTrailing) {
//                            if isShowCameraIcon {
//                                Rectangle()
//                                    .fill(appColor)
//                                    .frame(width: 40, height: 40)
//                                    .clipShape(RoundedRectangle(cornerRadius: 30))
//                                    .overlay(Image("ic_camera")
//                                        .onTapGesture {
//                                            showImagePickerOptions.toggle()
//                                        })
//                            }
//                        }
//                    if isShowCameraIcon == false {
//                        Text(title)
//                            .foregroundColor(appColor)
//                            .if (underlineTitle) { $0.underline() }
//                    }
//                }
//            }
//        }
//        .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: self.$localImage, isShown: self.$showImagePicker, sourceType: $sourceType)
//        }
//    }
//}
//
//struct DetailsPhotoView: View {
//    var imageUrlString: String?
//    @Binding var fullScreenPhoto: Bool
//
//    var body: some View {
//        if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
//            HStack {
//                KFImage(imageUrl)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 128, height: 128)
//                    .clipShape(Circle())
//                    .overlay(alignment: .bottomTrailing) {
//                        Image("ic_full_photo")
//                            .onTapGesture {
//                                fullScreenPhoto.toggle()
//                            }
//                    }
//                Spacer()
//            }
//            .padding(.bottom)
//        }
//    }
//}
//
//struct DetailsFullScreenPhotoView: View {
//    var imageUrlString: String
//    @Binding var fullScreenPhoto: Bool
//
//    var body: some View {
//        ZStack(alignment: .top) {
//            VStack {
//                Spacer()
//                KFImage(URL(string: imageUrlString))
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 310)
//                    .clipped()
//                Spacer()
//            }
//            .background(Color.black.opacity(0.5))
//            .background(.ultraThinMaterial)
//            HStack {
//                Button {
//                    fullScreenPhoto.toggle()
//                } label: {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.white)
//                }
//                Spacer()
//            }
//            .padding()
//        }
//        .zIndex(1.0)
//    }
//}
//
//// MARK: -
//struct UpdatingView: View {
//    var text = "Ajouté"
//    var body: some View {
//        ZStack {
//            Color.black.opacity(0.8)
//                .ignoresSafeArea()
//            ZStack {
//                RoundedRectangle(cornerRadius: 15)
//                    .foregroundColor(.white)
//                    .frame(width: 236, height: 51)
//                Text(text)
//                    .font(.system(size: 17), weight: .semibold)
//                    .foregroundColor(appColor)
//            }
//        }
//    }
//}
//
//struct Loader : View {
//    var tintColor = appColor
//    var body: some View{
//        ProgressView()
//            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
//    }
//}
//
//struct AlertMessageView: View {
//    var message: String
//    @Binding var showAlert: Bool
//    var body: some View {
//        VStack {
//            if showAlert {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 25)
//                        .foregroundColor(.black.opacity(0.42))
//                    HStack(alignment: .top) {
//                        Text(message)
//                            .font(.system(size: 13))
//                            .foregroundColor(.white)
//                            .padding(.leading)
//                            .padding(.vertical, 25)
//                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(.white)
//                            .padding(.trailing, 15)
//                            .padding(.top)
//                            .onTapGesture {
//                                showAlert = false
//                            }
//                    }
//                }
//                .fixedSize(horizontal: false, vertical: true)
//                .padding()
//            }
//        }
//    }
//}
//
//// MARK: - MyTextField
//struct MyTextField: UIViewRepresentable {
//    var placeholder = ""
//    @Binding var text: String
//    @Binding var isSecureTextEntry: Bool
////    var textContentType: UITextContentType = .newPassword
//    var onCommit: () -> Void = { }
//
//    func makeUIView(context: Context) -> UITextField {
//        let textField = UITextField(frame: .zero)
//        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        textField.placeholder = placeholder
//        textField.delegate = context.coordinator
//        textField.returnKeyType = .next
//        textField.text = self.text
//        textField.font = .systemFont(ofSize: 15)
//        textField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: digit; max-consecutive: 2; minlength: 8;")
//
//
//        _ = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
//            .compactMap {
//                guard let field = $0.object as? UITextField else {
//                    return nil
//                }
//                return field.text
//            }
//            .sink {
//                self.text = $0
//            }
//
//        return textField
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.isSecureTextEntry = isSecureTextEntry
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        var parent: MyTextField
//
//        init(_ textField: MyTextField) {
//            self.parent = textField
//        }
//
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            if let currentValue = textField.text as NSString? {
//                let proposedValue = currentValue.replacingCharacters(in: range, with: string) as String
//                self.parent.text = proposedValue
//            }
//            return true
//        }
////        func textFieldDidEndEditing(_ textField: UITextField) {
////            parent.onCommit()
////        }
//
//        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            parent.onCommit()
//            return true
//        }
//    }
//}

import AVKit
struct AVPlayerControllerRepresented : UIViewControllerRepresentable {
    @Binding var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}

struct NewMenuBaseView<Content: View>: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var confirmAlert = false
    let content: Content
    var title: String
    var alertTitle: String
    var height: CGFloat
    var backButton: Bool
    var padding: Bool
    var viewId = ""
    
    init(padding: Bool = true, height: CGFloat = 105, title: String, backButton: Bool = true,alertTitle: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.height = height
        self.backButton = backButton
        self.padding = padding
        self.alertTitle = alertTitle
    }
    var body: some View {
        ZStack {
//            if confirmAlert {
//                Color.black.opacity(0.8)
//                    .ignoresSafeArea()
//                    .overlay(MyAlert(title: "", message: alertTitle, ok: "Confirmer",
//                                     height: 150, action: {
//                        if viewId.isEmpty {
//                            navigationModel.hideTopViewWithReverseAnimation()
//                        } else {
//                            navigationModel.popContent(viewId)
//                        }
//                    }, showAlert: $confirmAlert))
//                    .zIndex(10.0)
//            }
            
            VStack(spacing: 0.0) {
                HStack {
                        if backButton {
                            Button(action: {
                                confirmAlert.toggle()
                            }) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.white)
                            }
                            .frame(height: 44)
                            .padding(.leading)
                        }
                        Spacer()
                        Text(title)
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
//                            .if(!backButton) {$0.padding(.bottom)}
                        Spacer()
                    }
                ScrollView(showsIndicators: false) {
                    VStack {
                        content
                    }
//                    .if(padding) {$0.padding()}
//                    .if(!padding) {$0.padding(.top)}
//                    .padding(.bottom, 80)
//                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .background(Color.white)
            }
        }
//        .alert(isPresented: $confirmAlert, content: {
//            Alert(title: Text("") , message: Text(alertTitle), primaryButton: .default(Text("Confirmer").foregroundColor(appColor), action: {
//                if viewId.isEmpty {
//                    navigationModel.hideTopViewWithReverseAnimation()
//                } else {
//                    navigationModel.popContent(viewId)
//                }
//            }), secondaryButton: .cancel(Text("Annuler").foregroundColor(.black)))
//        })
//        .alert(isPresented: $confirmAlert, content: {
//            Alert(title: Text(alertTitle), primaryButton: .default(Text("Confirmer").foregroundColor(appColor), action: {
//                if viewId.isEmpty {
//                    navigationModel.hideTopViewWithReverseAnimation()
//                } else {
//                    navigationModel.popContent(viewId)
//                }
//            }), secondaryButton: .cancel(Text("Annuler").foregroundColor(.black)))
//        })
    }
}
