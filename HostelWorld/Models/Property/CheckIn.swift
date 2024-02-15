//
//  CheckIn.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import RealmSwift
import Realm

@objcMembers
class CheckIn: EmbeddedObject, Decodable {
    
    dynamic var startsAt            : String!
    dynamic var endsAt              : String!
    
}
