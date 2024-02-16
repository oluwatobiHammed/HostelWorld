//
//  URLParameterEncoding.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation


// Struct implementing the ParameterEncoder protocol for encoding parameters as URL query parameters.
public struct URLParameterEncoder: ParameterEncoder {
    
    // Function to encode parameters as URL query parameters and update the URLRequest's URL.
    public func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters) throws {
        
        // Ensure the URLRequest has a valid URL.
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        // Create URLComponents to work with the existing URL.
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            // Clear existing query items and prepare to add new ones.
            urlComponents.queryItems = [URLQueryItem]()
            
            // Iterate through parameters and create URLQueryItems.
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            
            // Update the URLRequest's URL with the newly encoded parameters.
            urlRequest.url = urlComponents.url
        }
    }
}

