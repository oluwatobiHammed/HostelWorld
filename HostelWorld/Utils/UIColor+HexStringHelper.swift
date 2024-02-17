//
//  File.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import UIKit

extension UIColor {
    class var background: UIColor {
        get {
            return UIColor(red: 244/255.0, green: 248/255.0, blue: 249/255.0, alpha: 1.0)
        }
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let preparedRed   = CGFloat(r) / 255.0
        let preparedGreen = CGFloat(g) / 255.0
        let preparedBlue  = CGFloat(b) / 255.0
        
        self.init(red: preparedRed, green: preparedGreen, blue: preparedBlue, alpha: a)
    }
    
    convenience init(hexString: String) {
        var hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        _ = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            hexString = String(hexString.dropFirst())
        }
        
        var color: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        var hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        _ = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            hexString = String(hexString.dropFirst())
        }
        
        var color: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format: "#%06x", rgb) as String
    }
    
    func mixWithColor(color: UIColor, amount: CGFloat = 0.25) -> UIColor {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var alpha1: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var alpha2: CGFloat = 0
        
        self.getRed (&r1, green: &g1, blue: &b1, alpha: &alpha1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &alpha2)
        return UIColor( red: r1*(1.0-amount)+r2*amount,
                        green: g1*(1.0-amount)+g2*amount,
                        blue: b1*(1.0-amount)+b2*amount,
                        alpha: alpha1 )
    }
}
