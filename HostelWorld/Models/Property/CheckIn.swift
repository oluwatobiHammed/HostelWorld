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
    
    private enum CodingKeys: String, CodingKey {
           case startsAt, endsAt
       }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.startsAt                     = try container.decodeIfPresent(String.self, forKey: .startsAt)
        self.endsAt.value                     = try container.decodeIfPresent(Int.self, forKey: .endsAt)
    }
    
    dynamic var startsAt            : String?
    var endsAt                      = RealmProperty<Int?>()
}
