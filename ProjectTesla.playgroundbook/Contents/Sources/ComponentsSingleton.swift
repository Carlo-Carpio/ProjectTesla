//
//  ComponentsSingleton.swift
//
//  Created by Carlo Carpio on 21/03/2018.
//  Copyright © 2018 Carlo Carpio.

import UIKit

public final class ComponentsSingleton {
    public static let shared = ComponentsSingleton()
    
    
    //Array of basic electric components
    
    public let componentArray: [Component] = [Component(name: "Bulb", description: "It is one of the most common component and basically, converts electrical energy into heat and light.", image: UIImage(named: "BulbIcon.png")!), Component(name: "Battery", description: "It is a power source that slowly converts chemicals packed inside it into electrical energy and provides the voltage and current to energize a device attached to the circuit.", image: UIImage(named: "BatteryIcon.png")!), Component(name: "Switch", description: "It allows circuit to be opened or closed. When a switch open the circuit, the electric current can't travel. Viceversa, when a switch close the circuit, the electric current can travel.", image: UIImage(named: "SwitchIconOn.png")!), Component(name: "Buzzer", description: "It is an electrical device that makes a buzzing noise and is used for signalling. It converts electrical energy into sound energy.", image: UIImage(named: "BuzzerIcon.png")!), Component(name: "Motor", description: "A machine that supplies motive power for a vehicle or for another device with moving parts. It converts electrical energy into movement energy.", image: UIImage(named: "MotorIcon.png")!), Component(name: "Cable", description: "It is a conductor and allows the electric current to travel. It connects all the components of a circuit.", image: UIImage(named: "CableIcon.png")!)]
}
