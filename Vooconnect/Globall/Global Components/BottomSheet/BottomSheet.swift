//
//  BottomSheet.swift
//  vooconnect
//
//  Created by Online Developer on 04/10/2022.
//

import SwiftUI
import Swinject

enum BottomSheetType {
    case home
    case creatorMoreOptions(creatorProfileViewModel: CreatorProfileViewModel)
    case switchAccount
    case subscriberView
    case logout
    
    func view() -> AnyView {
        switch self {
        case .home:
            return AnyView(HomeBottomSheet())
        case .creatorMoreOptions(let creatorProfileViewModel):
            return AnyView(CreatorMoreOptionsView(creatorProfileViewModel: creatorProfileViewModel).frame(height: 500))
        case .switchAccount:
            return AnyView(SwitchAccountView().frame(height: 400))
        case .subscriberView:
            return AnyView(SubscribeView())
        case .logout:
            return AnyView(LogOutView())
        }
    }
}

struct BottomSheet: View {
    var appEventsManager = Container.default.resolver.resolve(AppEventsManager.self)!

    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                        appEventsManager.hideBottomSheet.send(true)
                    }
                    
                content
                    .padding(.bottom, 42)
                    .transition(.move(edge: .bottom))
                    .background(
                        Color.white
                    )
                    .cornerRadius(25, corners: [.topLeft, .topRight])
                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 3)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}
