//
//  City.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import RealmSwift
import Realm

@objcMembers
class City: EmbeddedObject, Decodable {
    
    dynamic var id                          : String!
    dynamic var name                        : String!
    dynamic var country                     : String!
    dynamic var idCountry                   : String!
    
}
