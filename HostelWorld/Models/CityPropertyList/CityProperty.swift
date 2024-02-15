//
//  CityProperty.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import RealmSwift
import Realm

@objcMembers
class CityProperty: Object, Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, name, city, latitude, longitude, type, images, overallRating
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                       = try container.decode(String.self, forKey: .id)
        self.name                     = try container.decodeIfPresent(String.self, forKey: .name)
        self.city                     = try container.decodeIfPresent(City.self, forKey: .city)
        self.latitude                 = try container.decodeIfPresent(String.self, forKey: .latitude)
        self.longitude                = try container.decodeIfPresent(String.self, forKey: .longitude)
        self.type                     = try container.decodeIfPresent(String.self, forKey: .type)
        if let results = try container.decodeIfPresent(Array<PropertyImage>.self, forKey: .images) {
            self.images.append(objectsIn: results)
        }
        self.overallRating            = try container.decodeIfPresent(OverallRating.self, forKey: .overallRating)
        
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    dynamic var id                  : String = ""
    dynamic var name                : String?
    dynamic var city                : City?
    dynamic var latitude            : String?
    dynamic var longitude           : String?
    dynamic var type                : String?
    dynamic var images              = List<PropertyImage>()
    dynamic var overallRating       : OverallRating?
}
