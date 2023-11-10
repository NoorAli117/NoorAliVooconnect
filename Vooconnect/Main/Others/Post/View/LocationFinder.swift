////
////  LocationFinder.swift
////  Vooconnect
////
////  Created by Noor on 10/11/2023.
////
//
//import SwiftUI
//import GooglePlaces
//
//struct PlaceSearch: View {
//
//    @State private var searchText = ""
//    @State private var placePredictions = [GMSPlace]()
//
//    private var googlePlacesClient: GMSPlacesClient = {
//        let apiKey = "YOUR_API_KEY"
//        return GMSPlacesClient(apiKey: apiKey)
//    }()
//
//    var body: some View {
//        VStack {
//            TextField(
//                "Search for a place",
//                text: $searchText
//            )
//            .onChange(of: searchText) { text in
//                placePredictions = []
//
//                if text.count > 3 {
//                    googlePlacesClient.autocompleteQuery(text, radius: 50000, filter: .establishment) { (results, error) in
//                        if let results = results {
//                            placePredictions = results
//                        }
//                    }
//                }
//            }
//
//            List(placePredictions) { place in
//                Text(place.name)
//            }
//        }
//    }
//}
//
