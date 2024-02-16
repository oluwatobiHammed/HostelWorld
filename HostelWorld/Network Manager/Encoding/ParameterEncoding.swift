//
//  ParameterEncoding.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation
import UIKit

// Dictionary type alias for representing parameters in HTTP requests.
public typealias Parameters = [String: Any]

// Type alias for representing array parameters in HTTP requests using Encodable.
public typealias ArrayParameters = T
public typealias T = Encodable

// Protocol defining the requirements for a parameter encoder.
public protocol ParameterEncoder {
    // Function to encode parameters and modify the provided URLRequest.
    func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters) throws
    
}



// Enum representing different types of parameter encoding for HTTP requests.
public enum ParameterEncoding {
    
    // Cases representing different encoding types.
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    case urlAndArrayJsonEncoding
    
    // Function to encode parameters and update the headers of a URLRequest.
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       bodyArrayParameters: ArrayParameters? = nil,
                       urlParameters: Parameters?) throws {
        do {
            // Ensure Content-Type, Accept, and Platform headers are set with default values if not present.
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            if urlRequest.value(forHTTPHeaderField: "Accept") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            }
            
            if urlRequest.value(forHTTPHeaderField: "Platform") == nil {
                urlRequest.setValue("ios", forHTTPHeaderField: "Platform")
            }
            
            // Determine the body parameters for clarity in the switch cases.
            let clarifiedBodyParameters: Parameters? = !(bodyParameters?.isEmpty ?? false) ? bodyParameters : nil
            
            // Determine the body array parameters for clarity in the switch cases.
            let clarifiedBodyArrayParameters: ArrayParameters? = bodyArrayParameters
            
            // Create a dictionary of parameters to be included in the URL.
            var params = urlParameters ?? [String: Any]()
            params.updateValue(getTimeZone(), forKey: "t")
            
            // Switch based on the specified encoding type.
            switch self {
            case .urlEncoding:
                // Encode parameters using URL encoding.
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
            case .jsonEncoding:
                // Encode URL parameters using URL encoding.
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
                // Encode body parameters using JSON encoding.
                if let bodyParameters = clarifiedBodyParameters {
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, withParameters: bodyParameters)
                }
                
            case .urlAndJsonEncoding:
                // Encode both URL and body parameters using URL and JSON encoding.
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
                if let bodyParameters = clarifiedBodyParameters {
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, withParameters: bodyParameters)
                }
                
            case .urlAndArrayJsonEncoding:
                // Encode both URL and body array parameters using URL and JSON encoding.
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
                if let bodyArrayParameters = clarifiedBodyArrayParameters {
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, withArrayParameters: bodyArrayParameters)
                }
            }
        } catch {
            // Propagate any errors encountered during encoding.
            throw error
        }
    }
}



// Function to get the current time zone in the format "+HH:mm" or "-HH:mm".
private func getTimeZone() -> String {
    let seconds = TimeZone.current.secondsFromGMT()
    let hours = seconds / 3600
    let minutes = abs(seconds / 60) % 60
    return String(format: "%+.2d:%.2d", hours, minutes)
}

// Enum representing network-related errors.
public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}


