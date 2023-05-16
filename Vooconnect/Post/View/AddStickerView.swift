//
//  EditTextView.swift
//  Vooconnect
//
//  Created by JV on 1/03/23.
//

import SwiftUI

struct AddStickerView: View {
    let ranges = [0x1F601...0x1F64F, 0x2702...0x27B0]
    private let data : [String]
    let columns = [
        GridItem(.adaptive(minimum: 70))
    ]
    var callback : (ContentOverlayModel, String) -> () = {content,str in}
    var cancellCallback : () -> () = {}
    init(callback : @escaping (ContentOverlayModel, String) -> () = {content,str in}, cancellCallback : @escaping () -> () = {}){
        self.callback = callback
        self.cancellCallback = cancellCallback
        data = ranges
            .flatMap { $0 }
            .compactMap { Unicode.Scalar($0) }
            .map(Character.init)
            .compactMap { String($0)}
    }
    var body: some View {
        ZStack{
            background()
            stickerView()
        }
        .padding(.vertical,20)
        
    }
    
    func background() -> some View{
        Rectangle()
            .fill(Color.black.opacity(0.35))
            .ignoresSafeArea()
            .onTapGesture {
                
                
            }
    }
    
    func stickerView() -> some View{
        return VStack(spacing:0){
            HStack{
                Text("cancel")
                    .urbanistRegular(fontSize: 24)
                    .button {
                        self.cancellCallback()
                    }
                Spacer()
            }
            .padding(.horizontal,25)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        Image(uiImage: item.image()! )
                            .resizable()
                            .scaledToFit()
    //                    Text(item)
                            .button {
                                let content = ContentOverlayModel(type: TypeOfOverlay.sticker, size: .zero, scale: 1, value: item,color: .white, fontSize: 1, enableBackground: false, font: .system)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    callback(content,item)
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical,20)
        }
        
        //        .ignoresSafeArea(.keyboard)
    }
}

struct AddStickerView_Previews: PreviewProvider {
    static var previews: some View {
        AddStickerView()
    }
}
