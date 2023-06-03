//
//  CategoryView.swift
//  Vooconnect
//
//  Created by Farooq Haroon on 6/3/23.
//

//import Foundation
import SwiftUI


struct CatBotSheetView: View {
    @ObservedObject var viewModel = CategoryViewModel()
    @State var selectedCat: Int
    var onItemSelected: ((Int) -> Void)?
    
    var body: some View {
        VStack {
            Text("Categories")
                .font(.custom("Urbanist-Bold", size: 16))
                .fontWeight(.bold)
                .padding()
            
            List{
                ForEach(viewModel.categories, id: \.id) { category in
                    HStack {
                        Button {
                            selectedCat = category.id
                            onItemSelected?(selectedCat)
                        } label: {
                            Text(category.categoryName)
                                .font(.custom("Urbanist-Bold", size: 12))
                                .padding(.horizontal, 22)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(CatButtonStyle(isSelected: selectedCat == category.id))
                    }
                    .padding(.vertical, 5)
                }
            }
        }        //            .onAppear {
        //                viewModel.fetchItems()
        //            }
    }
}

struct CatButtonStyle : ButtonStyle {
    var isSelected: Bool
 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .padding(.horizontal, 22)
            .padding(.vertical, 10)
            .padding(.top, 5)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(isSelected ? LinearGradient(colors: [
                        Color("buttionGradientTwo"),
                        Color("buttionGradientOne"),
                        Color("buttionGradientOne"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [
                        Color.clear,
                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .foregroundColor(isSelected ? .white : .black)
            .overlay(isSelected ? RoundedRectangle(cornerRadius: 25).stroke(Color.clear, lineWidth: 0) : RoundedRectangle(cornerRadius: 25).stroke(Color("buttionGradientOne"), lineWidth: 1.5))
    }
}
