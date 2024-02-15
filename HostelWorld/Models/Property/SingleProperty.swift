//
//  SingleProperty.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import RealmSwift
import Realm

@objcMembers
class SingleProperty: Object, Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, name, rating, description, city, address1, address2, directions, paymentMethods, policies, totalRatings, latitude, longitude, type, images, overallRating, depositPercentage, checkIn
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                       = try container.decode(String.self, forKey: .id)
        self.name                     = try container.decodeIfPresent(String.self, forKey: .name)
        self.city                     = try container.decodeIfPresent(City.self, forKey: .city)
        self.rating                   = try container.decodeIfPresent(Rating.self, forKey: .rating)
        self.latitude                 = try container.decodeIfPresent(String.self, forKey: .latitude)
        self.longitude                = try container.decodeIfPresent(String.self, forKey: .longitude)
        self.type                     = try container.decodeIfPresent(String.self, forKey: .type)
        self.totalRatings             = try container.decodeIfPresent(String.self, forKey: .totalRatings)
        self.depositPercentage        = try container.decodeIfPresent(String.self, forKey: .depositPercentage)
        self.directions               = try container.decodeIfPresent(String.self, forKey: .directions)
        self.propertDescription       = try container.decodeIfPresent(String.self, forKey: .description)
        if let results                = try container.decodeIfPresent(Array<PropertyImage>.self, forKey: .images) {
            self.images.append(objectsIn: results)
        }
        if let results                = try container.decodeIfPresent(Array<String>.self, forKey: .policies) {
            self.policies.append(objectsIn: results)
        }
        if let results                = try container.decodeIfPresent(Array<String>.self, forKey: .paymentMethods) {
            self.paymentMethods.append(objectsIn: results)
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
    dynamic var totalRatings        : String?
    dynamic var depositPercentage   : String?
    dynamic var propertDescription  : String?
    dynamic var directions          : String?
    dynamic var images              = List<PropertyImage>()
    dynamic var policies            = List<String>()
    dynamic var paymentMethods      = List<String>()
    dynamic var overallRating       : OverallRating?
    dynamic var checkIn             : CheckIn?
    dynamic var rating              : Rating?
    
}

