//
//  TextView.swift
//  Vooconnect
//
//  Created by Voconnect on 08/12/22.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    var placeholderText: String = "Hi everyone, in this video I will sing a song #song #music #love #beauty Thanks to @Vooconnect Video credit to"
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: 17)
        
        textView.text = placeholderText
        textView.textColor = .placeholderText
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        
        if text != "" || uiView.textColor == .label {
            uiView.text = text
            uiView.textColor = .label
        }
        
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
        }
    }
}


struct TextViewTwo: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var didStartEditing: Bool
    @Binding var placeholder: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()

        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true

        return textView
    }


    func updateUIView(_ uiView: UITextView, context: Context) {

        if didStartEditing {

            uiView.textColor = UIColor.black
            uiView.text = text

        }
        else {
//            = "Hi everyone, in this video I will sing a song #song #music #love #beauty Thanks to @Vooconnect Video credit to"
            uiView.text = placeholder
            uiView.textColor = UIColor.black
        }

        uiView.font = UIFont.preferredFont(forTextStyle: .body)
        
    }
}
struct DescriptionTextEditor: View {
    @Binding var text: String
    @State private var mentionData: String = ""
    @State private var isListVisible: Bool = false
    @State private var userName: [String] = []
    @State private var searchResults: [String] = []
    
    private let placeholder: String = "Hi everyone, in this video I will sing a song #song #music #love #beauty. Thanks to @Vooconnect! Video credit to"
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .font(.custom("Urbanist-Regular", size: 18))
                .padding(.leading, 4)
                .padding(.top, 8)
                .focused($isFocused)
                .clipped()
                .frame(height: 136)
                .onChange(of: text) { newValue in
                    print(newValue)
                    isListVisible = false
                    if let lastIndex = newValue.lastIndex(of: "@") {
                        let substring = newValue.suffix(from: newValue.index(after: lastIndex))
                        if (substring.last != " "){
                            if !substring.contains(" ") {
                                let newValueAfterAt = String(substring)
                                self.mentionData = newValueAfterAt
                                searchUsername()
                                isListVisible = true
                            }
                        }
                    } else {
                        isListVisible = false
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color("GradientOne"),
                                    Color("GradientTwo"),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 2
                        )
                        .padding(.leading, 4)
                )
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .padding(.top, 4)
                    .frame(height: 136)
            }
            
            if isListVisible {
                VStack {
                    ForEach(searchResults, id: \.self) { item in
                        Button(action: {
                            selectMention(item)
                            isListVisible = false
                        }) {
                            Text(item)
                        }
                        .foregroundColor(.primary)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding(.top, 40)
                .frame(width: 100)
                .background(Color.white.opacity(0.5))
                .cornerRadius(8)
                .shadow(radius: 4)
                .frame(height: 120)
                .onTapGesture {
                    isFocused = true
                    isListVisible = false
                }
            }
        }
    }
    
    private func selectMention(_ mention: String) {
        let mentionRange = text.range(of: mentionData, options: .caseInsensitive)
        
        if let range = mentionRange {
            text.replaceSubrange(range, with: "\(mention)")
            isListVisible = false
            mentionData = ""
        }
    }


    func searchUsername() {
        guard let url = URL(string: baseURL + EndPoints.mention) else {
            print("Invalid URL")
            return
        }

        let parameters: [String: Any] = [
            "username": mentionData
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let data = data {
                            do {
                                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                                if let results = jsonResponse as? [String: Any],
                                   let data = results["data"] as? [[String: Any]] {
                                    let usernames = data.compactMap { $0["username"] as? String }
                                    DispatchQueue.main.async {
                                        searchResults = usernames
                                    }
                                }
                            } catch {
                                print("Error parsing JSON: \(error)")
                            }
                        }
                    } else {
                        print("HTTP response status code: \(httpResponse.statusCode)")
                    }
                }
            }

            task.resume()

        } catch {
            print("Error creating JSON data: \(error)")
        }
    }
}
class SearchResultsWrapper: ObservableObject {
    @Published var searchResults: [String] = []
}
//"john","Ali","Hussain","Noor","Ayan","baqir","Hassan","Farooq"
