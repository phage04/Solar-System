//
//  ViewController.swift
//  Solar System
//
//  Created by Lyle Christianne Jover on 1/29/18.
//  Copyright © 2018 OnionApps Inc. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    
 
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let sun = SCNNode()
        sun.geometry = SCNSphere(radius: 0.35)
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "SunDiffuse")
        sun.position = SCNVector3Make(0, 0, -1)
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        sun.runAction(forever)
        
        let moonParent = SCNNode()
        let mercuryParent = SCNNode()
        let venusParent = SCNNode()
        let earthParent = SCNNode()
        let marsParent = SCNNode()
        let jupiterParent = SCNNode()
  
        let uranusParent = SCNNode()
        let neptuneParent = SCNNode()
        
        
        
        let mercury = planet(geometry: SCNSphere(radius: 0.076), diffuse: #imageLiteral(resourceName: "Mercury"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.4, 0, 0), spinDuration: 6)
        
        let venus = planet(geometry: SCNSphere(radius: 0.19), diffuse: #imageLiteral(resourceName: "VenusSurface"), specular: nil, emission: #imageLiteral(resourceName: "VenusAtmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0), spinDuration: 6)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "EarthDay"), specular: #imageLiteral(resourceName: "EarthSpecular"), emission: #imageLiteral(resourceName: "EarthEmission"), normal: #imageLiteral(resourceName: "EarthNormal"), position: SCNVector3Make(1.0, 0, 0), spinDuration: 6)
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3Make(0.3, 0, 0), spinDuration: 6)
        moonParent.runAction(rotation(time: 3))
        moonParent.addChildNode(moon)
        earth.addChildNode(moonParent)
        

        let mars = planet(geometry: SCNSphere(radius: 0.106), diffuse: #imageLiteral(resourceName: "Mars"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.3, 0, 0), spinDuration: 6)
        let jupiter = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "Jupiter"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.6, 0, 0), spinDuration: 6)
        let saturn = planet(geometry: SCNSphere(radius: 0.3), diffuse: #imageLiteral(resourceName: "Saturn"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0), spinDuration: 6)
        let saturnParent = planet(geometry: SCNTube(innerRadius: 0.35, outerRadius: 0.5, height: 0.01) , diffuse: #imageLiteral(resourceName: "SaturnRing"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1.9, 0, 0), spinDuration: 999)
        let uranus = planet(geometry: SCNSphere(radius: 0.25), diffuse: #imageLiteral(resourceName: "Uranus"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2.2, 0, 0), spinDuration: 6)
        let neptune = planet(geometry: SCNSphere(radius: 0.22), diffuse: #imageLiteral(resourceName: "Neptune"), specular: nil, emission: nil, normal: nil, position: SCNVector3(2.5, 0, 0), spinDuration: 6)
        
        mercuryParent.runAction(rotation(time: 3))
        mercuryParent.addChildNode(mercury)
        sun.addChildNode(mercuryParent)
        
        venusParent.runAction(rotation(time: 5))
        venusParent.addChildNode(venus)
        sun.addChildNode(venusParent)
        
        earthParent.runAction(rotation(time: 6))
        earthParent.addChildNode(earth)
        sun.addChildNode(earthParent)
        
        marsParent.runAction(rotation(time: 4))
        marsParent.addChildNode(mars)
        sun.addChildNode(marsParent)
        
        jupiterParent.runAction(rotation(time: 10))
        jupiterParent.addChildNode(jupiter)
        sun.addChildNode(jupiterParent)
        
        saturnParent.runAction(rotation(time: 12))
        saturnParent.addChildNode(saturn)
        sun.addChildNode(saturnParent)
        
        uranusParent.runAction(rotation(time: 8))
        uranusParent.addChildNode(uranus)
        sun.addChildNode(neptuneParent)
        
        neptuneParent.runAction(rotation(time: 6))
        neptuneParent.addChildNode(neptune)
        sun.addChildNode(neptuneParent)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        

    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3, spinDuration: Double) -> SCNNode {
        let planet  = SCNNode()
        planet.geometry = geometry
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        
        planet.runAction(rotation(time: spinDuration))
        
        return planet
        
    }
    
    func rotation(time: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let forever = SCNAction.repeatForever(action)
        return forever
    }


}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

