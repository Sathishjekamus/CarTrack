//
//  PaddingLabel.swift
//  HelloParentAdmin
//
//  Created by Sathish Kalimuthan on 11/12/19.
//  Copyright © 2019 Hello Parent. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + 0 + 0)
    }
    
    @IBInspectable open var characterSpacing:CGFloat = 1 {
             didSet {
                 let attributedString = NSMutableAttributedString(string: self.text!)
                 attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
                 self.attributedText = attributedString
             }

         }
    
}
