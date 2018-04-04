//Buzzer.swift
//Project Tesla
//
//Created by Carlo Carpio
import Foundation
import SpriteKit


private let textureBuzzer: SKTexture = SKTexture(imageNamed: "BuzzerIconSK")

public class Buzzer: SKSpriteNode {
    
    public init () {
        super.init(texture: textureBuzzer, color: .clear, size: textureBuzzer.size()/3)
        self.name = "Buzzer"
        self.texture?.filteringMode = .nearest
        
    }
    
    //--MARK: Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
