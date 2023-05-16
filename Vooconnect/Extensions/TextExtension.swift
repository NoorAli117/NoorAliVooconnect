//
//  TextExtension.swift
//  Vooconnect
//
//  Created by JV on 22/02/23.
//

import Foundation
import SwiftUI
extension Text{
    func poppinsBlack(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func poppinsBold(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func poppinsRegular(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func poppinsLight(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func urbanistBlack(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Urbanist-Black", size: fontSize))
    }
    
    func urbanistBold(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Urbanist-Bold", size: fontSize))
    }
    
    func urbanistRegular(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Urbanist-Regular", size: fontSize))
    }
    
    func urbanistLight(fontSize:Double=14) -> Text{
        return self
        .font(.custom("Urbanist-Light", size: fontSize))
    }
    
    func whiteColor() -> Text{
        return self
            .foregroundColor(ColorsHelper.white)
    }
    
    func blackColor() -> Text{
        return self
            .foregroundColor(ColorsHelper.black)
    }
}

extension View{
    func poppinsBlack(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func poppinsBold(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func poppinsRegular(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func poppinsLight(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Poppins-Black", size: fontSize))
    }
    
    func urbanistBlack(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Urbanist-Black", size: fontSize))
    }
    
    func urbanistBold(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Urbanist-Bold", size: fontSize))
    }
    
    func urbanistRegular(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Urbanist-Regular", size: fontSize))
    }
    
    func urbanistLight(fontSize:Double=14) -> some View{
        return self
            .font(.custom("Urbanist-Light", size: fontSize))
    }
    
    
    
}

