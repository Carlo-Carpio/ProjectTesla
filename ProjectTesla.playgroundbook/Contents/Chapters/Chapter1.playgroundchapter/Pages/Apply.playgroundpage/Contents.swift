/*:
 ## **First Ohm's Law**
 
 One of the most important and basic laws of electrical circuits is Ohm's law which states that the [Current](glossary://Current) passing through a conductor is proportional to the voltage
 over the resistance.
 
 * callout(First Ohm's Law):
    I = V/R
 
 Applying Ohm's First Law, you can also evaluate each formula parameters as:
 
 * **I** = V/R: Electric current is Voltage-Resistance ratio
 * **V** = R*I: Voltage is product of Resistance and Electric current
 * **R** = V/I: Resistance is Voltage-Electric current ratio
 
 ## **Apply concept**
 
 **Challenge**: Let's make some noise! Set the right value of the current to make the circuit work with a [Voltage](glossary://Voltage) of 10V and [Resistance](glossary://Resistance) of 5Ω.
 
 Tap `Run My Code` to see your changes.
 
 [**Next Page**](@next)
 
 ## Setup circuit:
 */

//#-hidden-code
//Contents.swift
//Copyright © 30/03/2018 Carlo Carpio

import UIKit
import PlaygroundSupport

let page = PlaygroundPage.current
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

var electricityEnabled: Bool = false {
    didSet {
        if electricityEnabled {
            proxy?.send(.string("electricity_enabled"))
        } else {
            proxy?.send(.string("electricity_not_enabled"))
        }
    }
}


var electricCurrentValue: Int = 0 {
    didSet {
        if (electricCurrentValue == 2) {
            proxy?.send(.string("correct-intensity-value"))
        } else {
            proxy?.send(.string("not-correct-intensity-value"))
        }
    }
}

PlaygroundPage.current.assessmentStatus = PlaygroundPage.AssessmentStatus.fail(hints: ["First you need to set the right current intensity value according to Ohm's First Law.","Once the current intensity value has been set up, you need to let current travel through the circuit!"], solution: "First, using Ohm's First Law to calculate the `I = V/R = 2`. Second, just put `true` for `electricityEnabled` value. Then, turn on the volume and start press the `switch`.")

//#-end-hidden-code
//#-code-completion(everything, hide)
electricCurrentValue = /*#-editable-code number*/0/*#-end-editable-code*/
//#-code-completion(identifier, show, true, false)
electricityEnabled = /*#-editable-code*/false/*#-end-editable-code*/
