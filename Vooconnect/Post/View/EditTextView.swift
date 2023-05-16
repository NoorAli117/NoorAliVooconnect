//
//  EditTextView.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import SwiftUI

struct EditTextView: View {
    @State var currentContent : ContentOverlayModel?
    @State private var text : String = ""
    @State private var enableBackground : Bool = true
    @State private var fontSize : Double = 34
    @State private var color : Color = .white
    @State private var isCallingBack : Bool = false
    @State private var customFont : Font = .system(size: 20)
    @State private var fontType = TypeFont.system
    @FocusState private var focusTextField: Bool
    private let colors : [Color] = [.white,.blue,.red,.yellow,.green,.brown,.cyan, .purple,.indigo,.mint,.orange,.pink,.teal,.gray]
    private let fonts : [TypeFont] = [.urbanistBold, .system,.urbanistBlack, .urbanistLight, .systemBold, ]
    var callback : (ContentOverlayModel, AnyView) -> () = {str,view in}
    var cancelCallback : () -> () = {}
    init(callback : @escaping (ContentOverlayModel, AnyView) -> () = {str,view in}, cancellCallback : @escaping () -> () = {}, currentContent : ContentOverlayModel? = nil)
    {
        _currentContent = State(initialValue: currentContent)
        self.cancelCallback = cancellCallback
        self.callback = callback
    }
    
    func setInitialValues() {
        if(self.currentContent != nil)
        {
            text = self.currentContent!.value
            color = self.currentContent!.color
            fontSize = self.currentContent!.fontSize
            enableBackground = self.currentContent!.enableBackground
            fontType = self.currentContent!.font
            customFont = getCustomFont(font: self.fontType)
        }
    }
    var body: some View {
        ZStack{
            background()
            textView()
            textControllers()
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.focusTextField = true
                self.isCallingBack = false
                self.setInitialValues()
            }
        }
        .onDisappear{
            self.focusTextField = false
        }
    }
    
    func background() -> some View{
        Rectangle()
            .fill(Color.black.opacity(0.35))
            .ignoresSafeArea()
            .onTapGesture {
                if(self.focusTextField)
                {
                    return
                }
                let content = ContentOverlayModel(type: TypeOfOverlay.text, size: .zero, scale: 1, value: text,color: color, fontSize: fontSize, enableBackground: enableBackground,font: fontType)
                self.focusTextField = false
                self.isCallingBack = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    if(text.isEmpty == false)
                    {
                        callback(content,AnyView(textView()))
                    }else{
                        cancelCallback()
                    }
                }
                
            }
    }
    
    func textView() -> some View{
        let textWidth = CGFloat(text.count) * 17
        var width = textWidth + 10 + fontSize
        if(width > UIScreen.main.screenWidth() - 48)
        {
            width = UIScreen.main.screenWidth() - 48
        }
        return VStack{
            Spacer()
            TextField("",text: $text)
                .font(customFont)
                .disabled(self.isCallingBack)
                .foregroundColor(color == .white ? .black : .white)
                .focused($focusTextField)
                .multilineTextAlignment(.center)
                .padding(.horizontal,12)
                .padding(.vertical,8)
                .background{
                    if(enableBackground && text.count > 0){
                        color
                            .cornerRadius(16)
                    }else if !enableBackground {
                        color.opacity(0.01)
                            .cornerRadius(16)
                    }
                }
                .fixedSize()
                .frame(maxWidth: UIScreen.main.screenWidth() - 36)
                .lineLimit(2)
                .truncationMode(.head)
            Spacer()
        }
        .padding(24)
//        .ignoresSafeArea(.keyboard)
    }
    
    func textControllers() -> some View{
        VStack(spacing:20){
            Spacer()
            HStack(spacing:20){
                Text("A")
                    .font(customFont)
                    .foregroundColor(enableBackground ? .black : .white)
                    .padding(.horizontal,12)
                    .padding(.vertical,8)
                    .background{
                        if(enableBackground){
                            Color.white
                                .cornerRadius(12)
                        }else{
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white, lineWidth: 4)
                                .cornerRadius(12)
                        }
                    }
                    .button {
                        enableBackground.toggle()
                        self.customFont = getCustomFont(font: self.fontType)
                    }
                    .foregroundColor(.black)
                
                Text("Aa")
                    .font(customFont)
                    .shadow(color: .white, radius: 2)
                    .button {
                        if(fontSize == 48)
                        {
                            fontSize = 24
                        }
                        else if(fontSize < 34)
                        {
                            fontSize = 34
                        }else{
                            fontSize = 48
                        }
                        self.customFont = getCustomFont(font: self.fontType)
                    }
                    .foregroundColor(.black)
            }
            ScrollView(.horizontal){
                
                HStack(spacing:20){
                    Spacer()
                        .frame(width: 10,height: 0)
                    ForEach(colors,id: \.self)
                    {col in
                        Circle()
                            .fill(col)
                            .background{
                                Circle()
                                    .stroke(.black, lineWidth: 6)
                            }
                            .frame(width: 25,height: 25)
                            .button {
                                color = col
                            }
                    }
                    Spacer()
                        .frame(width: 10,height: 0)
                }
                .padding(.vertical,10)
            }
            .padding(.horizontal,20)
            
            ScrollView(.horizontal){
                
                HStack(spacing:20){
                    Spacer()
                        .frame(width: 10,height: 0)
                    ForEach(fonts,id: \.self)
                    {font in
                        currentFontView(font: font)
                    }
                    Spacer()
                        .frame(width: 10,height: 0)
                }
                .padding(.vertical,10)
            }
            .padding(.horizontal,20)
        }
        .padding(.vertical,80)
    }
    
    func currentFontView(font : TypeFont) -> some View
    {
        let currentText = text.isEmpty ? "Some text" : text
        let currentFont = getCustomFont(font: font)
        return Text(currentText)
            .font(currentFont)
            .button {
                self.customFont = currentFont
                self.fontType = font
            }
            .foregroundColor(.black)
            .shadow(color:.white, radius: 2)
    }
    
    func getCustomFont(font : TypeFont) -> Font{
        var currentFont : Font = .system(size: fontSize)
        switch(font)
        {
            case .system : currentFont = .system(size: fontSize)
            case .systemBold : currentFont = .system(size: fontSize, weight: .bold)
            case .urbanistBold : currentFont = .custom("Urbanist-Bold", size: fontSize)
            case .urbanistBlack : currentFont = .custom("Urbanist-Black", size: fontSize)
            case .urbanistLight : currentFont = .custom("Urbanist-Light", size: fontSize)
        }
        return currentFont
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditTextView()
    }
}
