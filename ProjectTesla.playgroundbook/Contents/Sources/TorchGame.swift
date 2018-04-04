//TorchGame.swift
//Project Tesla
//
//Created by Carlo Carpio

import Foundation
import SpriteKit



public class TorchGame: SKScene {
    
    
    //--MARK: Init
    public override init(size: CGSize) {
        super.init(size: size)
        
    }
    
    //--MARK: Variables
    
    var bg = SKSpriteNode()
    var touchedNode = SKNode()
    
    //Torch node for back sprite
    var torchNode = SKSpriteNode()
    
    
    //Switch nodes
    var switchNode = SKSpriteNode()
    var switchContainer = SKShapeNode()
    
    //Bulb nodes
    var bulbNode = SKSpriteNode()
    var bulbContainer = SKShapeNode()
    
    //Battery nodes
    var batteryNode = SKSpriteNode()
    var batteryContainer = SKShapeNode()
    
    //Intersection parameters to check collision
    var intersectionSwitchOccurred = false
    var intersectionBulbOccurred = false
    var intersectionBatteryOccurred = false
    var rightSequenceOccurred = false
    
    //--MARK: Override
    public override func didMove(to view: SKView) {
        
        //Create Background
        bg.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 )
        bg.color = .init(red: 0.33, green: 0.58, blue: 0.94, alpha:1)
        bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        addChild(bg)
        
        //Create Torch
        torchNode = SKSpriteNode(imageNamed: "TorchRetro.png")
        torchNode.name = "Torch"
        torchNode.position = CGPoint(x: view.frame.midX, y: view.frame.midY - 100)
        torchNode.size = CGSize(width: torchNode.texture!.size().width / 3, height: torchNode.texture!.size().height / 3)
        addChild(torchNode)
        
        
        //Electric component containers
        //Create the switch component container
        switchContainer = SKShapeNode(rectOf: CGSize(width: 60, height: 60))
        switchContainer.name = "switchContainer"
        switchContainer.position = CGPoint(x: 0, y: 0)
        torchNode.addChild(switchContainer)
        
        //Create the battery component container
        batteryContainer = SKShapeNode(rectOf: CGSize(width: 60, height: 60))
        batteryContainer.name = "batteryContainer"
        batteryContainer.position = CGPoint(x: 0, y: -150)
        torchNode.addChild(batteryContainer)
        
        //Create the bulb component container
        bulbContainer = SKShapeNode(rectOf: CGSize(width: 60, height: 60))
        bulbContainer.name = "bulbContainer"
        bulbContainer.position = CGPoint(x: 0, y: 150)
        torchNode.addChild(bulbContainer)
    
        //Create Switch
        switchNode = SKSpriteNode(imageNamed: "SwitchIconOnSK.png")
        switchNode.name = "Switch"
        switchNode.position = CGPoint(x: view.frame.midX, y: view.frame.maxY - 80)
        switchNode.size = CGSize(width: switchNode.texture!.size().width / 12, height: switchNode.texture!.size().height / 12)
        print("Switch size: \(switchNode.texture!.size())")
        addChild(switchNode)
        
        //Create Battery
        batteryNode = SKSpriteNode(imageNamed: "BatteryIconSK.png")
        batteryNode.name = "Battery"
        batteryNode.position = CGPoint(x: view.frame.midX - 150, y: view.frame.maxY - 80)
        batteryNode.size = CGSize(width: batteryNode.texture!.size().width / 12, height: batteryNode.texture!.size().height / 12)
        addChild(batteryNode)
        print("Battery size: \(batteryNode.texture!.size())")
        
        //Create Bulb
        bulbNode = SKSpriteNode(imageNamed: "BulbIconSK.png")
        bulbNode.name = "Bulb"
        bulbNode.position = CGPoint(x: view.frame.midX + 150, y: view.frame.maxY - 80)
        bulbNode.size = CGSize(width: bulbNode.texture!.size().width / 12, height: bulbNode.texture!.size().height / 12)
        addChild(bulbNode)
        print("Bulb size: \(bulbNode.texture!.size())")
        
        //Create Separator
        let separator = SKShapeNode(rectOf: CGSize(width: view.frame.width - 50, height: 5))
        separator.position = CGPoint(x: view.frame.midX, y: view.frame.midY + 300)
        addChild(separator)
        
    }
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let locationF = touch.location(in: self) 
            let locationO = touch.previousLocation(in: self)
            let deltaLocation = CGPoint(x: locationF.x - locationO.x, y: locationF.y - locationO.y)
            
            touchedNode.position.y = deltaLocation.y + touchedNode.position.y
            touchedNode.position.x = deltaLocation.x + touchedNode.position.x
            
        }
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchDown(atPoint: touch.location(in: self))
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchUp(atPoint: touch.location(in: self))
    }
    
    //--MARK: Custom functions
    //Check collision between switchNode and switch container
    func checkCollisionSwitch() {
        guard !rightSequenceOccurred else { return }
            if switchNode.intersects(switchContainer) {
                
                switchNode.position = switchContainer.position
                switchNode.removeFromParent()
                switchNode.name = "intersectedSwitch"
                torchNode.addChild(switchNode)
                
                intersectionSwitchOccurred = true
                
            }
        }
    
    //Check collision between bulbNode and bulb container
    func checkCollisionBulb() {
       guard !rightSequenceOccurred else { return }
        if bulbNode.intersects(bulbContainer) {
            
            bulbNode.position = bulbContainer.position
            bulbNode.removeFromParent()
            bulbNode.name = "intersectedBulb"
            torchNode.addChild(bulbNode)

            intersectionBulbOccurred = true
        }
    }
    
    //Check collision between batteryNode and batetry container
    func checkCollisionBattery() {
        guard !rightSequenceOccurred else { return }
        if batteryNode.intersects(batteryContainer) {
            
            batteryNode.position = batteryContainer.position
            batteryNode.removeFromParent()
            batteryNode.name = "intersectedBattery"
            torchNode.addChild(batteryNode)
            
            intersectionBatteryOccurred = true
        }
    }
    
    //Check the sequence Bulb - Switch - Battery
    func checkRightSequence() {
        if (intersectionBulbOccurred == true && intersectionSwitchOccurred == true && intersectionBatteryOccurred == true) {
            
            rightSequenceOccurred = true
            
            //TorchFrontNode Creation
            let torchFrontNode = SKSpriteNode(imageNamed: "TorchFront")
            torchFrontNode.name = "TorchFront"
            torchFrontNode.position = CGPoint(x: view!.frame.maxX, y: view!.frame.midY - 100)
            torchFrontNode.size = CGSize(width: torchFrontNode.texture!.size().width / 3, height: torchFrontNode.texture!.size().height / 3)
            addChild(torchFrontNode)
            
            torchFrontNode.zPosition = 10
            
            self.switchNode.removeFromParent()
            self.switchContainer.removeFromParent()
            self.bulbNode.removeFromParent()
            self.bulbContainer.removeFromParent()
            self.batteryNode.removeFromParent()
            self.batteryContainer.removeFromParent()
            
            torchFrontNode.run(SKAction.move(to: torchNode.position, duration: 1)) {
                let lightNode = SKSpriteNode(imageNamed: "LightBeacon")
                lightNode.position = CGPoint(x: torchFrontNode.position.x, y: torchFrontNode.position.y + 330)
                lightNode.size = CGSize(width: lightNode.texture!.size().width, height: lightNode.texture!.size().height / 2)
                lightNode.alpha = 0.75
                self.addChild(lightNode)
            }
        }
        
    }
    
    func touchDown (atPoint pos: CGPoint) {
        let touchedNode = self.atPoint(pos)
        
        if touchedNode.name == "Switch" || touchedNode.name == "Battery" || touchedNode.name == "Bulb" {
            self.touchedNode = touchedNode
        }
    }
    
    func touchUp (atPoint pos: CGPoint) {
        touchedNode = SKNode()
    }
    
    //--MARK: Update
    public override func update(_ currentTime: TimeInterval) {
        checkCollisionSwitch()
        checkCollisionBulb()
        checkCollisionBattery()
        
        if rightSequenceOccurred == false {
            checkRightSequence()
        }
    }
    
    //--MARK: Required Init
    public required init? (coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

