//
//  FontConstants.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import UIKit

enum kFont: String {

    case EffraBold = "Effra-Bold"
    case EffraItalic = "Effra-Italic"
    case EffraRegular = "Effra-Regular"
    case EffraBoldItalic = "Effra-BoldItalic"
    
    case EffraHeavyItalic = "EffraHeavy-Italic"
    case EffraHeavyRegular = "EffraHeavy-Regular"
    
    case EffraMediumRegular = "EffraMedium-Regular"
    case EffraMediumItalic = "EffraMedium-Italic"
    
    case EffraLightItalic = "EffraLight-Italic"
    case EffraLightRegular = "EffraLight-Regular"
    
    
    case UniversLight = "Univers-Light"
    
    case Digital7 = "Digital-7"

    case RacingSansOneRegular = "RacingSansOne-Regular"
    
    case ShrikhandRegular  = "Shrikhand-Regular"
    
    public func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }

    static let homeSectionTitle = kFont.EffraRegular.of(size: 14)

}

