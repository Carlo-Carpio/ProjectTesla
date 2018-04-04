//MathConstant.swift
//Project Tesla
//
//Created by Carlo Carpio

import Foundation
import SpriteKit

//Extension for CGSize class to allow the division function between CGSize and CGFloat
extension CGSize {
    static public func / (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width / scalar, height: size.height / scalar)
    }
}

