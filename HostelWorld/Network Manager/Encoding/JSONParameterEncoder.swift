//
//  JSONParameterEncoder.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation



// Struct implementing the ParameterEncoder protocol for encoding parameters as JSON.
public struct JSONParameterEncoder: ParameterEncoder {

    // Function to encode parameters as JSON and set the HTTP body of the URLRequest.
    public func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters) throws {
        do {
            // Convert parameters to JSON data.
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            // Set the HTTP body of the URLRequest.
            urlRequest.httpBody = jsonAsData
            
        } catch {
            // Throw a NetworkError if encoding fails.
            throw NetworkError.encodingFailed
        }
    }
    
    // Function to encode array parameters as JSON and set the HTTP body of the URLRequest.
    public func encode(urlRequest: inout URLRequest, withArrayParameters arrayParameters: ArrayParameters) throws {
        do {
            // Use JSONEncoder to encode array parameters to JSON data.
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            urlRequest.httpBody = try encoder.encode(arrayParameters)
            
        } catch {
            // Throw a NetworkError if encoding fails.
            throw NetworkError.encodingFailed
        }
    }
    
}



