//
//  NetworkingEndpointTests.swift
//  HostelWorldTests
//
//  Created by Oladipupo Oluwatobi on 19/02/2024.
//

import XCTest
@testable import HostelWorld

class NetworkingEndpointTests: XCTestCase {
    
    func test_with_property_endpoint_request_is_valid() {
        let endpoint = HWEndpoints.getCityProperties
        
        XCTAssertEqual(endpoint.baseURL, URL(string: kAPI.Base_URL), "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, kAPI.Endpoints.city, "The path should be /cities/1530/properties/")
        XCTAssertEqual(endpoint.httpMethod, .get, "The method type should be GET")
        XCTAssertEqual(endpoint.baseURL.appendingPathComponent(HWEndpoints.getCityProperties.path).absoluteString, "http://private-anon-7bfd3141f6-practical3.apiary-mock.com/cities/1530/properties/", "The generated doesn't match our endpoint")
    }
    
    func test_with_property_Details_endpoint_request_is_valid() {
        let endpoint = HWEndpoints.getProperty(id: "80771")
        
        XCTAssertEqual(endpoint.baseURL, URL(string: kAPI.Base_URL), "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, kAPI.Endpoints.property+"80771", "The path should be /properties/80771")
        XCTAssertEqual(endpoint.httpMethod, .get, "The method type should be GET")
        XCTAssertEqual(endpoint.baseURL.appendingPathComponent(HWEndpoints.getProperty(id: "80771").path).absoluteString, "http://private-anon-7bfd3141f6-practical3.apiary-mock.com/properties/80771", "The generated doesn't match our endpoint")
    }

}
