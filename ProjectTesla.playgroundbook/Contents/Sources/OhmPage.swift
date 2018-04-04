//OhmPage.swift
//Project Tesla
//
//Created by Carlo Carpio
import Foundation
import SpriteKit


public class OhmPage: SKScene {
    
    //--MARK: Variables
    var bg = SKSpriteNode()
    
    var batteryNode = Battery()
    var switchNode = SwitchN()
    var buzzerNode = Buzzer()
    var touchedNode = SKNode()
    var firstCableSectionNode = SKSpriteNode()
    var secondCableSectionNode = SKSpriteNode()
    var buzzerAudioNode = SKAudioNode()
    let textureSwitchOn = SKTexture(imageNamed: "SwitchIconOnSK")
    let textureSwitchOff = SKTexture(imageNamed: "SwitchIconOff")
    
    //--MARK: Proxy parameters
    var electricityEnabled = false
    var correctIntensityValue = false
    
    //--MARK: Override
    public override init(size: CGSize) {
            super.init(size: size)
        }
    
    public override func didMove(to view: SKView) {
        
        //Crate background
        bg.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 )
        bg.color = .init(red: 0.33, green: 0.58, blue: 0.94, alpha:1)
        bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        addChild(bg)
        
        //Battery
        batteryNode.position =  CGPoint(x: view.frame.width / 2, y: view.frame.height / 8 )
        addChild(batteryNode)
        
        //Switch
        switchNode.position =  CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 )
        addChild(switchNode)
        
        //Buzzer
        buzzerNode.position =  CGPoint(x: view.frame.width / 2, y: view.frame.height - 130)
        addChild(buzzerNode)
        
        //Cable Section 1
        firstCableSectionNode = SKSpriteNode(imageNamed: "Cable.png")
        firstCableSectionNode.position = CGPoint(x: buzzerNode.position.x,
                                                 y:buzzerNode.position.y - firstCableSectionNode.size.height/4.8)
        firstCableSectionNode.size = CGSize(width: 60, height: self.frame.size.height / 5)
        firstCableSectionNode.zPosition = 0
        firstCableSectionNode.alpha = 0.8
        
        addChild(firstCableSectionNode)
        
        //Cable Section 2
        secondCableSectionNode = SKSpriteNode(imageNamed: "Cable.png")
        secondCableSectionNode.position = CGPoint(x: switchNode.position.x,
                                                  y: switchNode.position.y - secondCableSectionNode.size.height/5)
        secondCableSectionNode.size = CGSize(width: 60, height: self.frame.size.height / 5)
        secondCableSectionNode.zPosition = 0
        secondCableSectionNode.alpha = 0.8
        
        addChild(secondCableSectionNode)
        
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
    func touchDown (atPoint pos: CGPoint) {
        let touchedNode = self.atPoint(pos)
        
        if touchedNode.name == switchNode.name{
            self.touchedNode = touchedNode
        } 
        
    }
    
    func touchUp (atPoint pos: CGPoint) {
        
        let touchedNode = self.atPoint(pos)
        
        if (touchedNode.name == switchNode.name) && (switchNode.enabledSwitch == false) {
            switchNode.texture = textureSwitchOn
            switchNode.size = textureSwitchOn.size() / 3
            switchNode.run(SKAction.playSoundFileNamed("SwitchOn.wav", waitForCompletion: false))
            switchNode.enabledSwitch = true
            
            if electricityEnabled == true && correctIntensityValue == true {
                buzzerAudioNode = SKAudioNode(fileNamed: "buzzer.wav")
                addChild(buzzerAudioNode)
                buzzerAudioNode.autoplayLooped = true
            }
        } else if (touchedNode.name == switchNode.name) && (switchNode.enabledSwitch == true) {
                switchNode.texture = textureSwitchOff
                switchNode.size = textureSwitchOff.size() / 3
                switchNode.enabledSwitch = false
                switchNode.run(SKAction.playSoundFileNamed("SwitchOff.wav", waitForCompletion: true))
                buzzerAudioNode.run(SKAction.stop())
                buzzerAudioNode.removeFromParent()
            }
    }

    //--MARK: Required Init
    public required init? (coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
