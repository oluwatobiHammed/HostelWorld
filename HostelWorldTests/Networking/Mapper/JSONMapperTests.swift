//
//  JSONMapperTests.swift
//  HostelWorldTests
//
//  Created by Oladipupo Oluwatobi on 19/02/2024.
//

import Foundation
import XCTest
@testable import HostelWorld

class JSONMapperTests: XCTestCase {
    
    func test_with_valid_json_successfully_decodes() {
        
        XCTAssertNoThrow(LocalJSONDecoder().decode(CityProperties.self, fromFileNamed: "PropertyList"), "Mapper shouldn't throw an error")
        
        let properties = LocalJSONDecoder().decode(CityProperties.self, fromFileNamed: "PropertyList")
        XCTAssertNotNil(properties, "User response shouldn't be nil")
             
        XCTAssertEqual(properties?.properties.count, 19, "properties number should be 19")
        
        XCTAssertEqual(properties?.properties.first?.id, "32849", "The id should be 32849")
        XCTAssertEqual(properties?.properties[0].type, "HOSTEL", "The property type should be HOSTEL")
        XCTAssertEqual(properties?.properties[0].name, "STF Vandrarhem Stigbergsliden", "The property name should be STF Vandrarhem Stigbergsliden")
        XCTAssertEqual(properties?.properties[0].overallRating?.overall.value, 82, "The overall Rating value should be 82")
        XCTAssertEqual(properties?.properties[0].latitude, "57.6992285", "The latitude should be 57.6992285")
        
        XCTAssertEqual(properties?.properties[0].longitude, "11.9368171", "The longitude should be 11.9368171")
        XCTAssertEqual(properties?.properties[0].city?.name, "Gothenburg", "The city name should be Gothenburg")

    }
    
}
