//
//  ComponentCollectionViewCell.swift
//
//  Created by Carlo Carpio on 21/03/2018.
//  Copyright © 2018 Carlo Carpio.
//

import UIKit

@objc(ComponentCollectionViewCell)
public class ComponentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak public var componentImage: UIImageView!
    public var currentComponent: Component = Component(name: "", description: "", image:UIImage())
    
    public func config(forComponent component: Component) {
        componentImage.image = component.componentImage
        currentComponent = component
    }
    
}
