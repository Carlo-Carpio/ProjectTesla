//Battery.swift
//Project Tesla
//
//Created by Carlo Carpio
import Foundation
import SpriteKit


private let textureBattery: SKTexture = SKTexture(imageNamed: "BatteryIconSK")

public class Battery: SKSpriteNode {
    
    public init () {
        super.init(texture: textureBattery, color: .clear, size: textureBattery.size()/3)
        self.name = "Battery"
        self.texture?.filteringMode = .nearest
    }
     
    //--MARK: Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

