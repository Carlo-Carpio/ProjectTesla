//Switch.swift
//Project Tesla
//
//Created by Carlo Carpio
//Copyright
import Foundation
import SpriteKit


private let textureSwitchOff = SKTexture(imageNamed: "SwitchIconOff")

public class SwitchN: SKSpriteNode {
    
    public var enabledSwitch = false
    
    public init () {
        super.init(texture: textureSwitchOff, color: .clear, size: textureSwitchOff.size()/3)
        self.name = "Switch"
        self.texture?.filteringMode = .nearest
    }
    
    //--MARK: Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
