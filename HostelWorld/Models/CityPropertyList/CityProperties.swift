//
//  CityProperties.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import RealmSwift
import Realm

@objcMembers
class CityProperties: Object, Decodable {
    private enum CodingKeys: String, CodingKey {
        case properties
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let results = try container.decodeIfPresent(Array<CityProperty>.self, forKey: .properties) {
            self.properties.append(objectsIn: results)
        }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    dynamic var id                : Int = 0
    dynamic var properties        = List<CityProperty>()
}
