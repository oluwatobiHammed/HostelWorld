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
    
    
    private enum CodingKeys: String, CodingKey {
           case overall, numberOfRatings
       }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall.value                     = try container.decodeIfPresent(Int.self, forKey: .overall)
        self.numberOfRatings.value                     = try container.decodeIfPresent(Int.self, forKey: .numberOfRatings)
    }
    
    var overall                        = RealmProperty<Int?>()
    var numberOfRatings                 = RealmProperty<Int?>()
    
}

