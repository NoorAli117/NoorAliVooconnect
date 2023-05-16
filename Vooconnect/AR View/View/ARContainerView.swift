//
//  ARViewContainer.swift
//  Vooconnect
//
//  Created by JV on 4/03/23.
//
import SwiftUI
import RealityKit

struct ARContainerView : View {
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    var body: some View {
        ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all)
            .overlay{
                #if targetEnvironment(simulator)
                Rectangle()
                    .fill(.blue)
                #endif
            }
            .overlay {
                arViewSelectionView()
            }
    }
    
    func arViewSelectionView() -> some View{
        VStack{
            Spacer()
            ScrollView(.horizontal){
                HStack{
                    Spacer()
                        .frame(width: 24)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text("Glasses")
                                .foregroundColor(.black)
                        }
                        .button {
                            arViewModel.setArView(TypeOfARView.glasses)
                        }
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text("Mario Hat")
                                .foregroundColor(.black)
                        }
                        .button {
                            arViewModel.setArView(TypeOfARView.marioHat)
                        }
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text("Monster mask")
                                .foregroundColor(.black)
                        }
                        .button {
                            arViewModel.setArView(TypeOfARView.monsterMask)
                        }
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text("Girl hair")
                                .foregroundColor(.black)
                        }
                        .button {
                            arViewModel.setArView(TypeOfARView.girlHair)
                        }
                }
            }
        }
        .padding(.vertical,36)
    }
}

struct ARViewContainer: UIViewRepresentable {
    var arViewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ARContainerView_Previews : PreviewProvider {
    static var previews: some View {
        ARContainerView()
    }
}
#endif
