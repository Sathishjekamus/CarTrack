//
//  ButtonExtension.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit

@IBDesignable
class ButtonExtension: UIButton {
   
    @IBInspectable var cornurRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornurRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var borderwidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderwidth
            clipsToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    

}

extension UIButton{
    func pulsate() {
           
           let pulse = CASpringAnimation(keyPath: "transform.scale")
           pulse.duration = 0.3
           pulse.fromValue = 0.95
           pulse.toValue = 1.0
           pulse.autoreverses = true
           pulse.repeatCount = 1
           pulse.initialVelocity = 0.5
           pulse.damping = 1.0
           layer.add(pulse, forKey: "pulse")
       }
     
         func flash() {
           
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.1
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 1
           layer.add(flash, forKey: nil)
            
       }
       
     
       func shake() {
           
           let shake = CABasicAnimation(keyPath: "position")
           shake.duration = 0.1
           shake.repeatCount = 1
           shake.autoreverses = true
           let fromPoint = CGPoint(x: center.x - 5, y: center.y)
           let fromValue = NSValue(cgPoint: fromPoint)
           let toPoint = CGPoint(x: center.x + 5, y: center.y)
           let toValue = NSValue(cgPoint: toPoint)
           shake.fromValue = fromValue
           shake.toValue = toValue
           layer.add(shake, forKey: "position")
       }
}
