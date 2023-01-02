//
//  UIView+Extension.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
///

import Foundation
import UIKit


extension UIView {
    
    func image() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func addSubviews(_ array:[UIView]){
        for view in array{
            addSubview(view)
        }
    }
    
    func dropShadow(_ radius:CGFloat? = 8 ) {
        
        self.layer.cornerRadius = radius!
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.shadowRadius = 4.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.75
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func makeCircle(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
    func setCornerRadius(_ radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func seBorderColor(_ color:UIColor){
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func setCornerRadiusAndBorderColor(with radius:CGFloat, color:UIColor){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
         let className = String.className(viewType)
         return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
     }
     
     class func loadNib() -> Self {
         return loadNib(self)
     }
    
}
