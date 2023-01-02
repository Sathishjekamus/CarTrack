//
//  UITextFieldExtension.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import UIKit

 extension UITextField {
   
    func setBorderColor(with color:UIColor! = .lightGray){
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func setCornerRadius(with radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setShadow(){
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.shadowRadius = 4.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.75
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
           self.leftView = paddingView
           self.leftViewMode = .always
       }
       
       func setRightPaddingPoints(_ amount:CGFloat) {
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
           self.rightView = paddingView
           self.rightViewMode = .always
       }
    
}
