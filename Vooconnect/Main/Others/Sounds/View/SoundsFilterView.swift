//
//  PostVisibilityView.swift
//  Vooconnect
//
//  Created by JV on 25/03/23.
//

import SwiftUI
struct SoundsFilterView: View {
    var callback : (TypeOfSoundFilter) -> () = {val in}
    var cancellCallback : () -> () = {}
    let list : [TypeOfSoundFilter] = [.all,.title,.artist]
    @State var currentTypeFilter : TypeOfSoundFilter
    @State private var yOffset : CGFloat = 400
    init(currentTypeFilter : TypeOfSoundFilter = .all, callback : @escaping (TypeOfSoundFilter) -> () = {val in}, cancellCallback :@escaping () -> () = {})
    {
        _currentTypeFilter = State(initialValue: currentTypeFilter)
        self.cancellCallback = cancellCallback
        self.callback = callback
    }
    var body: some View {
        ZStack{
            background()
            postOptions()
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.yOffset = -50
            }
        }
    }
    
    func background() -> some View{
        Rectangle()
            .fill(Color.black.opacity(0.35))
            .ignoresSafeArea()
            .onTapGesture {
//                self.yOffset = 400
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    callback(self.currentTypeFilter)
//                }
            }
            .opacity(yOffset > 100 ? 0 : 1)
            .animation(.easeInOut, value: self.yOffset)
    }
    
    func postOptions() -> some View{
        VStack{
            Spacer()
            VStack(alignment:.leading,spacing: 5){
                HStack(alignment:.center){
                    Text("Cancel")
                        .urbanistBold(fontSize: 18)
                        .foregroundColor(.gray)
                        .button{
                            self.yOffset = 400
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.cancellCallback()
                            }
                            
                        }
                    Spacer()
                    Text("Filters")
                        .urbanistBold(fontSize: 24)
                        .padding(.bottom,10)
                    Spacer()
                    Text("Apply")
                        .urbanistBold(fontSize: 18)
                        .foregroundColor(.gray)
                        .button{
                            self.yOffset = 400
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.callback(self.currentTypeFilter)
                            }
                        }
                }
                Rectangle()
                    .fill(.gray)
                    .frame(height: 0.5)
                    .padding(.bottom,15)
                HStack{
                    ForEach(list, id: \.self)
                    {type in
                        Text(type.description)
                            .foregroundColor(.black)
                            .padding(15)
                            .background{
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 12)
                                            .strokeBorder(.black,lineWidth: currentTypeFilter == type ? 1 : 0 )
                                    }
                                    
                                
                            }
                            .button {
                                self.currentTypeFilter = type
                            }
                    }
                }
               
            }
            .padding(.horizontal,48)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .padding(.vertical,-20)
                    .padding(.bottom,-100)
                    .frame(width: UIScreen.main.screenWidth() - 48)
                
            }
            .offset(y : yOffset)
            .animation(.easeInOut, value: self.yOffset)
        }
    }
}

struct SoundsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsFilterView()
    }
}
