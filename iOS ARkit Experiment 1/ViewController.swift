//
//  ViewController.swift
//  iOS ARkit Experiment 1
//
//  Created by mac on 3/27/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView!
    var button:UIButton!!
    var box: SCNBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sceneView = ARSCNView()
        sceneView.frame = view.frame
        sceneView.delegate = self
        view.addSubview(sceneView)
        
        let configuration = ARWorldTrackingConfriguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        
        setupButton()
        setupBox()
    }
    
    func setupButton() {
        button = UIButton(frame: CGRect(x:view.frame.width *0.2, y:view.frame.height, width: view.frame.width*0.6, height: view.frame.height, *0.1))
        button.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(buttonPressed),, for:.touchUpInside)
        view.addSubview(button)
    }
    func setupBox() {
        box = SCNBox(width, eight, length, chamferRadius)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "dirt")
        box.materials = [material]
    }
    
    @objc
    func buttonPressed(){
        print("Button was pressed!")
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraObject = MDLTransform(matrix: cameraTransform!)
        var boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(cameraObject.translation)
        boxNode.eulerAangles = SCNVector3(cameraObject.rotation)
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


