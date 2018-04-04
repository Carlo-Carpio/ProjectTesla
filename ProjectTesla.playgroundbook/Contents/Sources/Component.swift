//
//  Components.swift
//
//  Created by Carlo Carpio on 21/03/2018.
//  Copyright © 2018 Carlo Carpio.

import UIKit

public class Component {
    
    
    //Name
    public var name: String?
    
    
    //Brief Description
    public var description: String?
    
    
    //Main Image
    public var componentImage: UIImage?
    
    
    //Init
    public required init(name: String, description: String, image: UIImage) {
        self.name = name
        self.description = description
        self.componentImage = image
    }
}
