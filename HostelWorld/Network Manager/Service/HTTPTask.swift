//
//  HTTPTask.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestArrayParametersAndHeaders(bodyParameters: ArrayParameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestHeaders(bodyEncoding: ParameterEncoding)
    
}
