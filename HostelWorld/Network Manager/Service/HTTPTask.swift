//
//  HTTPTask.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

// Enumeration representing different types of tasks associated with an HTTP request.
public enum HTTPTask {
    // Simple request without parameters or headers.
    case request
    
    // Request with body parameters, URL parameters, and specified body encoding.
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    
    // Request with body parameters, URL parameters, headers, and specified body encoding.
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?)
    
    // Request with array body parameters, URL parameters, headers, and specified body encoding.
    case requestArrayParametersAndHeaders(bodyParameters: ArrayParameters?,
                                          bodyEncoding: ParameterEncoding,
                                          urlParameters: Parameters?)
    
    // Request with headers and specified body encoding.
    case requestHeaders(bodyEncoding: ParameterEncoding)
}

