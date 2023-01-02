//
//  String.swift
//  CarTrack
//
//  Created by Helix Technical Services on 02/01/23.
//

import Foundation
import UIKit
import AVFoundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidMobileNumber() -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: self)
        return result
    }
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func trim() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func urlencoding() -> String {
        var output: String = ""
        
        for thisChar in self {
            if thisChar == " " {
                output += "+"
            }
            else if thisChar == "." ||
                thisChar == "-" ||
                thisChar == "_" ||
                thisChar == "~" ||
                (thisChar >= "a" && thisChar <= "z") ||
                (thisChar >= "A" && thisChar <= "Z") ||
                (thisChar >= "0" && thisChar <= "9") {
                let code = String(thisChar).utf8.map{ UInt8($0) }[0]
                output += String(format: "%c", code)
            }
            else {
                let code = String(thisChar).utf8.map{ UInt8($0) }[0]
                output += String(format: "%%%02X", code)
            }
        }
        
        return output;
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        let startIndex1 = self.index(self.startIndex, offsetBy:from)
        return String(self[startIndex1...])
    }
    
    var length: Int {
        return self.count
    }
    
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
}
