//
//  OverallRating.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import RealmSwift
import Realm

@objcMembers
class OverallRating: EmbeddedObject, Decodable {
    
    dynamic var suffix                 : String!
    dynamic var prefix                 : String!
    
}

