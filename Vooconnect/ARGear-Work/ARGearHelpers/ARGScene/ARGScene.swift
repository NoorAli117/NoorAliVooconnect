//
//  ARGScene.swift
//  ARGearSample
//
//  Created by Jaecheol Kim on 2019/11/07.
//  Copyright © 2019 Seerslab. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

typealias ARGSceneRenderUpdateAtTimeHandler = (SCNSceneRenderer, TimeInterval) -> Void
typealias ARGSceneRenderDidRenderSceneHandler = (SCNSceneRenderer, SCNScene, TimeInterval) -> Void

class ARGScene: NSObject {
    
    var sceneRenderUpdateAtTimeHandler: ARGSceneRenderUpdateAtTimeHandler?
    var sceneRenderDidRenderSceneHandler: ARGSceneRenderDidRenderSceneHandler?
    
    lazy var sceneView = SCNView()
    lazy var sceneCamera = SCNCamera()
    
    init(viewContainer: UIView?){
        super.init()
        
        guard
          let scene = SCNScene(named: "vooconnect/Face.scnassets/face.scn")
        else {
            fatalError("Failed to load face scene!")
        }
    }
}

extension ARGScene: SCNSceneRendererDelegate {

    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        guard
            let handler = sceneRenderUpdateAtTimeHandler
            else {
            return
        }

        handler(renderer, time)
    }

    public func renderer( _ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        guard
            let handler = sceneRenderDidRenderSceneHandler
            else {
            return
        }

        handler(renderer, scene, time)
    }
}
