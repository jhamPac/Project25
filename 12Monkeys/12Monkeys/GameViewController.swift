//
//  GameViewController.swift
//  12Monkeys
//
//  Created by jhampac on 2/12/16.
//  Copyright (c) 2016 jhampac. All rights reserved.
//

import UIKit
import SpriteKit

protocol LaunchDelegate: class
{
    func launch(angle angle: Int, velocity: Int)
}

class GameViewController: UIViewController, GameSceneControllerDelegate
{
    var currentGame: GameScene!
    weak var launchDelegate: LaunchDelegate?
    
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var playerNumber: UILabel!
    
    @IBAction func angleChanged(sender: UISlider)
    {
        angleLabel.text = "Angle: \(Int(angleSlider.value))"
    }
    
    @IBAction func velocityChanged(sender: UISlider)
    {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(sender: UIButton)
    {
        angleSlider.hidden = true
        angleLabel.hidden = true
        velocitySlider.hidden = true
        velocityLabel.hidden = true
        
        launchButton.hidden = true
        
        if let delegate = launchDelegate
        {
            delegate.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene")
        {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            launchDelegate = scene
            scene.sceneDelegate = self
            
            skView.presentScene(scene)
            
            angleChanged(angleSlider)
            velocityChanged(velocitySlider)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "restartGame", name: "gameOver", object: nil)
        }
    }

    override func shouldAutorotate() -> Bool
    {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            return .AllButUpsideDown
        }
        else
        {
            return .All
        }
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    func activatePlayerNumber(number: Int)
    {
        if number == 1
        {
            playerNumber.text = "<<< PLAYER ONE"
        }
        else
        {
            playerNumber.text = "PLAYER TWO >>>"
        }
        
        angleSlider.hidden = false
        angleLabel.hidden = false
        
        velocitySlider.hidden = false
        velocityLabel.hidden = false
        
        launchButton.hidden = false
    }
    
    func restartGame()
    {
        if let scene = GameScene(fileNamed:"GameScene")
        {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            launchDelegate = scene
            scene.sceneDelegate = self
            
            let transition = SKTransition.doorwayWithDuration(1.5)
            skView.presentScene(scene, transition: transition)
            
            angleChanged(angleSlider)
            velocityChanged(velocitySlider)
        }
    }
}
