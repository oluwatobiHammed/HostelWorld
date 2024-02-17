//
//  NetworkManagerMock.swift
//  HostelWorldTests
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//


import XCTest
@testable import HostelWorld

class NetworkManagerMock: NetworkManagerProtocol {
    
    var fileName: String!
    
    func getCityProperties() async -> ResultApi<CityProperties, Error> {
        
        if let fileName, let properties = LocalJSONDecoder().decode(CityProperties.self, fromFileNamed: fileName) {
           return .success(properties)
        } else {
            return .failure(MockError.mockError)
        }
    }
    
    func getProperty(id: String) async -> ResultApi<SingleProperty, Error> {
        if !id.isEmpty, let fileName, let property = LocalJSONDecoder().decode(SingleProperty.self, fromFileNamed: fileName) {
           return .success(property)
        } else {
            return .failure(MockError.mockError)
        }
    }
    
    
}
   

enum MockError: Error {
    case mockError
}
