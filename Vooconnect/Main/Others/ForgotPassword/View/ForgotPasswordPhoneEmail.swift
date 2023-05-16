//
//  ForgotPasswordPhoneEmail.swift
//  Vooconnect
//
//  Created by Vooconnect on 18/11/22.
//

import SwiftUI

struct ForgotPasswordPhoneEmail: View {
    
    let detail: ForgotPasswordSuccessDetail?
    
    var body: some View {
        Text(detail?.email ?? "ksjdfhfytfivt")
    }
}

//struct ForgotPasswordPhoneEmail_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordPhoneEmail()
//    }
//}
