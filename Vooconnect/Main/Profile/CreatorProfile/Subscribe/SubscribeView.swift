//
//  SubscribeView.swift
//  Vooconnect
//
//  Created by Online Developer on 09/03/2023.
//

import SwiftUI

struct SubscribeView: View {
    
    @StateObject var subscriberViewModel = SubscriberViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 30){
                SubscribeHeaderView()
                    .padding(.top, 40)
                SubscriberPlanView()
                SubscriberPlanView()
                Spacer()
            }
            .padding(.horizontal)
        }
        .frame(height: 500)
    }
}
