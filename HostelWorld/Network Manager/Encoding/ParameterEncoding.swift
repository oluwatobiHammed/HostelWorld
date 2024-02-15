//
//  ParameterEncoding.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation
import UIKit

public typealias Parameters = [String : Any]
public typealias ArrayParameters = T
public typealias T = Encodable

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters) throws
    
}


public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    case urlAndArrayJsonEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       bodyArrayParameters: ArrayParameters? = nil,
                       urlParameters: Parameters?,
                       imageTuple: (UIImage?, String)? = nil) throws {
        do {
            
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            if urlRequest.value(forHTTPHeaderField: "Accept") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            }
            
            if urlRequest.value(forHTTPHeaderField: "Platform") == nil {
                urlRequest.setValue("ios", forHTTPHeaderField: "Platform")
            }
            
            let clarifiedBodyParameters: Parameters? = !(bodyParameters?.isEmpty ?? false) ? bodyParameters : nil
            
            let clarifiedBodyArrayParameters: ArrayParameters? = bodyArrayParameters

            
            var params = urlParameters ?? [String: Any]()
            params.updateValue(getTimeZone(), forKey: "t")
            params.updateValue(getClientVersion(), forKey: "clientVersion")
            
            
            switch self {
            case .urlEncoding:
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
            case .jsonEncoding:
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
                if let bodyParameters = clarifiedBodyParameters {
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, withParameters: bodyParameters)
                }
                
                
            case .urlAndJsonEncoding:
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
                if let bodyParameters = clarifiedBodyParameters {
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, withParameters: bodyParameters)
                }
                
                
            case .urlAndArrayJsonEncoding:
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, withParameters: params)
                
                if let bodyArrayParameters = clarifiedBodyArrayParameters {
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, withArrayParameters: bodyArrayParameters)
                }
                
                
            }
        } catch {
            throw error
        }
    }
}



private func getTimeZone() -> String {
    let seconds = TimeZone.current.secondsFromGMT()
    let hours = seconds/3600
    let minutes = abs(seconds/60) % 60
    return String(format: "%+.2d:%.2d", hours, minutes)
}

private func getClientVersion() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}


public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

