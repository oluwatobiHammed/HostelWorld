//
//  Rating.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import RealmSwift
import Realm

@objcMembers
class Rating: EmbeddedObject, Decodable {
    
    dynamic var overall            : Int = 0
    dynamic var atmosphere         : Int = 0
    dynamic var cleanliness        : Int = 0
    dynamic var facilities         : Int = 0
    dynamic var staff              : Int = 0
    dynamic var security           : Int = 0
    dynamic var location           : Int = 0
    dynamic var valueForMoney      : Int = 0
    
}

