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
    
    private enum CodingKeys: String, CodingKey {
           case overall, atmosphere, cleanliness, facilities, staff, security, location, valueForMoney
       }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall.value                     = try container.decodeIfPresent(Int.self, forKey: .overall)
        self.atmosphere.value                     = try container.decodeIfPresent(Int.self, forKey: .atmosphere)
        self.cleanliness.value                     = try container.decodeIfPresent(Int.self, forKey: .cleanliness)
        self.facilities.value                     = try container.decodeIfPresent(Int.self, forKey: .facilities)
        self.staff.value                     = try container.decodeIfPresent(Int.self, forKey: .staff)
        self.security.value                     = try container.decodeIfPresent(Int.self, forKey: .security)
        self.location.value                     = try container.decodeIfPresent(Int.self, forKey: .location)
        self.valueForMoney.value                     = try container.decodeIfPresent(Int.self, forKey: .valueForMoney)
    }
    
    var overall                         = RealmProperty<Int?>()
    var atmosphere                      = RealmProperty<Int?>()
    var cleanliness                     = RealmProperty<Int?>()
    var facilities                      = RealmProperty<Int?>()
    var staff                           = RealmProperty<Int?>()
    var security                        = RealmProperty<Int?>()
    var location                        = RealmProperty<Int?>()
    var valueForMoney                   = RealmProperty<Int?>()
    
}

