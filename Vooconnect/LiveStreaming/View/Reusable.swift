//
//  Reusable.swift
//  Vooconnect
//
//  Created by Naveen Yadav on 11/04/23.
//

import SwiftUI


struct BlinkViewModifier: ViewModifier {
    
    let duration: Double
    @State private var blinking: Bool = false
    
    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0 : 1)
            .animation(.easeOut(duration: duration).repeatForever())
            .onAppear {
                withAnimation {
                    blinking = true
                }
            }
    }
}

extension View {
    func blinking(duration: Double = 0.75) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
}

class UIEmojiTextField: UITextField {
    
    var isEmoji = false {
        didSet {
            setEmoji()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setEmoji() {
        self.reloadInputViews()
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" && self.isEmoji{
                self.keyboardType = .default
                return mode
                
            } else if !self.isEmoji {
                return mode
            }
        }
        return nil
    }
    
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isEmoji: Bool
    var resignClosur: ((Bool) -> Void)
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        emojiTextField.isEmoji = self.isEmoji
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
        uiView.isEmoji = isEmoji
        if isEmoji == true {
            uiView.becomeFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.resignClosur(false)
            parent.isEmoji = false
            textField.textColor = .white
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.resignClosur(true)
            textField.textColor = .black
            textField.becomeFirstResponder()
        }
        
//        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//            parent.resignClosur(true)
//            textField.textColor = .black
//            textField.becomeFirstResponder()
//            return true
//        }
    }
}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}


func percentWidth(percentage: CGFloat?) -> CGFloat {
    if let percentage = percentage {
        let a = (screenWidth / 100) * percentage
        return a
    }
    return 0
}

func percentHeight(percentage: CGFloat?) -> CGFloat {
    if let percentage = percentage {
        let a = (screenHeight / 100) * percentage
        return a
    }
    return 0
}
