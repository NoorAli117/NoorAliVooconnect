//
//  ARModel.swift
//  Vooconnect
//
//  Created by JV on 4/03/23.
//

import Foundation
import RealityKit
import ARKit

struct ARModel {
    private(set) var arView : ARView
    var entity : ModelEntity!
    var typeOfAr : TypeOfARView = TypeOfARView.glasses
    init() {
        arView = ARView(frame: .zero)
        arView.session.run(ARFaceTrackingConfiguration())
        setTypeOfAr(typeOfAr)
    }
    
    
    
    mutating func setTypeOfAr(_ type : TypeOfARView)
    {
        switch(type)
        {
            case .marioHat:
                initMarioHatModel()
            case .monsterMask:
                initMonsterMaskModel()
            case .glasses:
                initGlassesModel()
            case .girlHair:
                initGirlHairScene()
        }
        typeOfAr = type
        
    }
    
    ///Init glasses model
    mutating func initGirlHairScene(){
        arView.scene.anchors.removeAll()
        guard let anchor = try? CurlyHairScene.loadScene() else { return }
        arView.scene.addAnchor(anchor)
    }
    
    ///Init glasses model4
    mutating func initGlassesModel(){
        arView.scene.anchors.removeAll()
        guard let anchor = try? GlassesScene.loadScene() else { return }
        arView.scene.addAnchor(anchor)
    }
    
    ///Iniit mario hat model
    mutating func initMarioHatModel(){
        arView.scene.anchors.removeAll()
        guard let anchor = try? MarioHatScene.loadScene() else { return }
        arView.scene.addAnchor(anchor)
//        arView.scene.anchors.removeAll()
//        let anchorEntity = AnchorEntity()
//        entity = try! ModelEntity.loadModel(named: "marioHat")
//        entity.scale = [0.001, 0.001, 0.001]
//        entity.name = "marioHat"
////        currentModelName = "marioHat"
//        anchorEntity.addChild(entity)
//        arView.scene.addAnchor(anchorEntity)
    }
    
    ///Iniit mario hat model
    mutating func initMonsterMaskModel(){
        arView.scene.anchors.removeAll()
        guard let anchor = try? MonsterMask.loadScene() else { return }
        arView.scene.addAnchor(anchor)
        
//        let anchorEntity = AnchorEntity()
//        entity = try! ModelEntity.loadModel(named: "monsterMask")
//        entity.scale = [0.001, 0.001, 0.001]
//        entity.name = "monsterMask"
//        currentModelName = "monsterMask"
//        anchorEntity.addChild(entity)
//        arView.scene.addAnchor(anchorEntity)
    }
    
    mutating func update(faceAnchor: ARFaceAnchor){
//        test(faceAnchor: faceAnchor)
//        smileRight = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .mouthSmileRight})?.value ?? 0)
//        print(smileRight)
//        smileLeft = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .mouthSmileLeft})?.value ?? 0)
//        addHat(faceAnchor: faceAnchor)
//        switch(typeOfAr){
//            case .marioHat:
//                addMarioHat(faceAnchor: faceAnchor)
//            case .glasses:
//                addGlasses(faceAnchor: faceAnchor)
//            case .monsterMask:
//                addMonsterMask(faceAnchor: faceAnchor)
//        }
    }
    
    mutating func test(faceAnchor: ARFaceAnchor){
//        arView.session.add(anchor: faceAnchor)
//        arView.scene.anchors.removeAll()
//        let anchor = AnchorEntity(anchor: faceAnchor)
//        anchor.scale *= 1
//
//        let mesh: MeshResource = try! .generate(from: [nutsAndBoltsOf(faceAnchor)])
//        var material = SimpleMaterial(color: .blue, isMetallic: false)
//        let model = ModelEntity(mesh: mesh, materials: [material])
//        anchor.addChild(model)
//        arView.scene.anchors.append(anchor)
    }
    
    private func nutsAndBoltsOf(_ anchor: ARFaceAnchor) -> MeshDescriptor {
        
        let vertices: [simd_float3] = anchor.geometry.vertices
        var triangleIndices: [UInt32] = []
        let texCoords: [simd_float2] = anchor.geometry.textureCoordinates
        
        for index in anchor.geometry.triangleIndices {         // [Int16]
            triangleIndices.append(UInt32(index))
        }
//        print(vertices.count)         // 1220 vertices
        
        var descriptor = MeshDescriptor(name: "canonical_face_mesh")
        descriptor.positions = MeshBuffers.Positions(vertices)
        descriptor.primitives = .triangles(triangleIndices)
        descriptor.textureCoordinates = MeshBuffers.TextureCoordinates(texCoords)
        return descriptor
    }

    
    ///Add glasses of 'glasses2' model to an arview
    mutating func addGlasses(faceAnchor: ARFaceAnchor){
//        if(currentModelName != "glasses")
//        {
//            initGlassesModel()
//        }
//        let anchor = arView.scene.anchors.first(where: {val in val.findEntity(named: currentModelName) != nil})
//        guard let anchor = anchor else{
//            print("anchor is nil")
//            return
//        }
//
//        anchor.transform.matrix = faceAnchor.transform
//        let scaleFactor : Float = 1.1
//        anchor.scale = vector_float3(x: anchor.scale.x * scaleFactor, y: anchor.scale.y * scaleFactor, z: anchor.scale.z * scaleFactor)
//        anchor.position = vector_float3(x:anchor.position.x, y:anchor.position.y + 0.03, z:anchor.position.z + 0.05)
//        arView.scene.anchors.remove(at: 0)
//        arView.scene.addAnchor(anchor)
    }
    
    ///Add glasses of 'marioHat' model to an arview
    mutating func addMarioHat(faceAnchor: ARFaceAnchor){
//        if(currentModelName != "marioHat")
//        {
//            initMarioHatModel()
//        }
//        let anchor = arView.scene.anchors.first(where: {val in val.findEntity(named: currentModelName) != nil})
//        guard let anchor = anchor else{
//            print("anchor is nil")
//            return
//        }
//        anchor.transform.matrix = faceAnchor.transform
//        let scaleFactor : Float = 1.1
//        anchor.scale = vector_float3(x: anchor.scale.x * scaleFactor, y: anchor.scale.y * scaleFactor, z: anchor.scale.z * scaleFactor)
////        anchor.transform.translation = vector_float3(x: vector.x, y: vector.y, z: vector.z - 0.5)
////        let rEye = faceAnchor.geometry.vertices[42] // Right eye
////        let lEye = faceAnchor.geometry.vertices[1064] // Left eye
////        let headPos = vector_float3(x: (rEye.x + lEye.x)/2, y: (rEye.y + lEye.y)/2, z: (rEye.z + lEye.z)/2)
//        anchor.position = vector_float3(x:anchor.position.x, y:anchor.position.y - 0.01 , z:anchor.position.z - 0.075)
//        anchor.transform.rotation += simd_quatf(angle: degreesToRadians(10), axis: vector_float3(x: 1, y: 0, z: 0))
//        arView.scene.anchors.remove(at: 0)
//        arView.scene.addAnchor(anchor)
    }
    
    ///Add glasses of 'marioHat' model to an arview
    mutating func addMonsterMask(faceAnchor: ARFaceAnchor){
//        if(currentModelName != "monsterMask")
//        {
//            initMonsterMaskModel()
//        }
//        let anchor = arView.scene.anchors.first(where: {val in val.findEntity(named: currentModelName) != nil})
//        guard let anchor = anchor else{
//            print("anchor is nil")
//            return
//        }
//        anchor.transform.matrix = faceAnchor.transform
//        let scaleFactor : Float = 10
//        anchor.scale = vector_float3(x: anchor.scale.x * scaleFactor, y: anchor.scale.y * scaleFactor, z: anchor.scale.z * scaleFactor)
//        anchor.position = vector_float3(x:anchor.position.x, y:anchor.position.y  - 0.8, z:anchor.position.z - 0.1)
//        anchor.transform.rotation += simd_quatf(angle: degreesToRadians(10), axis: vector_float3(x: 0, y: 1, z: 0))
//        arView.scene.anchors.remove(at: 0)
//        arView.scene.addAnchor(anchor)
    }
    
    private func degreesToRadians(_ degrees : Float) -> Float{
        return degrees * .pi / 180
    }
    
//    func getPoint(){
//        Vector3 midPoint = Vector3.Lerp(LeftEyeAnchor.transform.position, RightEyeAnchor.transform.position, 0.5f);
//           Vector3 direction = Vector3.Lerp(-LeftEyeAnchor.transform.forward, -RightEyeAnchor.transform.forward, 0.5f);
//           Ray ray = new Ray(midPoint, direction);
//           float distance = Vector3.Distance(midPoint, ARCamera.transform.position);
//           distance -= ARCamera.nearClipPlane;
//           Vector lookAtWorldPos = ray.GetPoint(distance);
//           // convert from world pos to UI
//
//    }
}
