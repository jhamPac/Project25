//
//  GameScene.swift
//  12Monkeys
//
//  Created by jhampac on 2/12/16.
//  Copyright (c) 2016 jhampac. All rights reserved.
//

enum CollisionTypes: UInt32 {
    case Banana = 1
    case Building = 2
    case Player = 4
}

import SpriteKit

class GameScene: SKScene
{
    var buildings = [BuildingNode]()
    weak var viewController: GameViewController!
    
    override func didMoveToView(view: SKView)
    {
        backgroundColor = UIColor(hue: 0.669, saturation: 0.99, brightness: 0.67, alpha: 1)
        createBuildings()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
      
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        
    }
    
    func createBuildings() {
        var currentX: CGFloat = -15
        
        while currentX < 1024 {
            let size = CGSize(width: RandomInt(min: 2, max: 4) * 40, height: RandomInt(min: 300, max: 600))
            currentX += size.width + 2
            
            let building = BuildingNode(color: UIColor.redColor(), size: size)
            building.position = CGPoint(x: currentX - (size.width / 2), y: size.height / 2)
            building.setup()
            addChild(building)
            
            buildings.append(building)
        }
    }
    
    func launch(angle angle: Int, velocity: Int)
    {
        
    }
}
