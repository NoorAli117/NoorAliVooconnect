//
//  ChatView.swift
//  Vooconnect
//
//  Created by Vooconnect on 05/12/22.
//

import SwiftUI

struct ChatView: View {
    
    @Environment(\.presentationMode) var presentaionMode
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Image("BackButton")
                }
                Spacer()
            }
            .padding(.leading)
            Text("Chat")
        }
        Spacer()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
