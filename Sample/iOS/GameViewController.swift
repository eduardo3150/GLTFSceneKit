//
//  GameViewController.swift
//  GLTFSceneKitSampler
//
//  Created by magicien on 2017/08/26.
//  Copyright © 2017年 DarkHorse. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import GLTFSceneKit

class GameViewController: UIViewController {
    
    var gameView: SCNView? {
        get { return self.view as? SCNView }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var scene: SCNScene
        do {
//            let sceneSource = try GLTFSceneSource(named: "art.scnassets/GlassVase/Wayfair-GlassVase-BCHH2364.glb")
            let sceneSource = try GLTFSceneSource(named: "art.scnassets/GlassVase/jonathan_with_assets.glb")
//            let sceneSource = try GLTFSceneSource(named: "art.scnassets/GlassVase/BoxAnimated.glb")
            scene = try sceneSource.scene()
            
            testAnimations(scene: scene)
        } catch {
            print("\(error.localizedDescription)")
            return
        }
        
        self.setScene(scene)
        
        self.gameView!.autoenablesDefaultLighting = true
        
        // allows the user to manipulate the camera
        self.gameView!.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // configure the view
        self.gameView!.backgroundColor = UIColor.gray
    }
    
    private func testAnimations(scene: SCNScene) {
        // For jonathan_with_assets glb, this is the following node breakdown
        let hair = scene.rootNode.childNodes[1].childNodes[0] // nil morpher
        hair.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .fill //This allows you to change material attached to the gemoetry to lines vs fill
        
        let headRoot = scene.rootNode.childNodes[0]
        let earNode = headRoot.childNodes[0] //nil morpher
        earNode.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .lines
        
        let eyelashes = headRoot.childNodes[1]
        let eyelashesTargets = headRoot.childNodes[1].childNodes[0].childNodes[0].morpher?.targets //18 elements
        
        let lowerteeth = headRoot.childNodes[3] //nil morpher
        lowerteeth.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .lines
        
        let tongue = headRoot.childNodes[4]
        tongue.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .lines
        let tongueTargets = headRoot.childNodes[4].childNodes[0].childNodes[0].morpher?.targets //4 elements
        
        let upperteeth = headRoot.childNodes[5] //nil morpher
        upperteeth.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .lines
        
        let eyeleft = headRoot.childNodes[6]
        eyeleft.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .lines
        let eyeleftTargets = headRoot.childNodes[6].childNodes[0].childNodes[0].morpher?.targets //1 element
        
        let eyeright = headRoot.childNodes[7]
        eyeright.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .lines
        let eyerightTargets = headRoot.childNodes[7].childNodes[0].childNodes[0].morpher?.targets //1 element
        
        let head = headRoot.childNodes[2]
        head.childNodes[0].childNodes[0].geometry?.firstMaterial?.fillMode = .lines
        let headMorpher = headRoot.childNodes[2].childNodes[0].childNodes[0].morpher
        let headTargets = headMorpher?.targets //56 elements
        

//        let allNodes = collectNodes(node: scene.rootNode, condition: { (n) -> Bool in
//            return true
//        })
//        allNodes.forEach { node in
//            playAllAnimations(node: node)
//        }
        
    }
    
    private func playAllAnimations(node: SCNNode) {
        
        node.animationPlayer(forKey: "Take 001")?.play()
        
//        for key in node.animationKeys {
//            node.animationPlayer(forKey: key)?.pla
//            print("*** \(node.name) : \(key)")
//            //node.removeAllAnimations()
//        }
    }
    
    private func collectNodes(node: SCNNode, condition: (SCNNode) -> Bool) -> [SCNNode] {
        var collected: [SCNNode] = []
        if condition(node) {
            collected.append(node)
        }
        node.childNodes.forEach { n in
            collected.append(contentsOf: collectNodes(node: n, condition: condition))
        }
        return collected
    }
    
    func setScene(_ scene: SCNScene) {
        // set the scene to the view
        self.gameView!.scene = scene
        //to give nice reflections :)
        scene.lightingEnvironment.contents = "art.scnassets/shinyRoom.jpg"
        scene.lightingEnvironment.intensity = 2;
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
