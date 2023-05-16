//
//  PopUpDismiss.swift
//  Vooconnect
//
//  Created by Vooconnect on 20/12/22.
//

import SwiftUI

extension View{
    
    // MARK: Building a Custom Modifier for Custom Popup navigation View
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40,show: Binding<Bool>,@ViewBuilder content: @escaping ()->Content)->some View{
        
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                
                if show.wrappedValue{
                    
                    // MARK: Geometry Reader for reading Container Frame
                    GeometryReader{proxy in
                        
                        Color.primary
                            .opacity(0.50)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView{
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / 1.4, alignment: .center) // 1.7
                        // Corner Radius
                        .cornerRadius(40)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}
