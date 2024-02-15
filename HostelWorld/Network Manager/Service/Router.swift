//
//  Router.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import SwiftUI

enum NetworkResponse:String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case unableToConvertToImage = "We could not convert response data to image."
}

enum Result<Error>{
    case success
    case failure(Error)
}

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint) async -> (Data?,URLResponse?, Error?)
}


class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private let session = URLSession(configuration: .default)
    private var task: URLSessionTask?
    
    private var isDebugModeEnabled: Bool = {
        guard let debugModeState = Bundle.main.object(forInfoDictionaryKey: "DebugModeState") as? NSString, debugModeState.boolValue else { return false }
        return debugModeState.boolValue
    }()
    
    
    func request(_ route: EndPoint) async -> (Data?,URLResponse?, Error?) {
        
        do {
            
            let request = try buildRequest(from: route)
            NetworkLogger.log(request: request)
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return (nil, nil, handleNetworkResponse(HTTPURLResponse()))
                }
            return (data, response,handleNetworkResponse(response))
        } catch {
           return (nil, nil, error)
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Error?{
        switch response.statusCode {
        case 200...299: break
        case 404: break
        case 401...500: return  NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.authenticationError.rawValue])
        case 501...599: return  NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.badRequest.rawValue])
        case 600: return  NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.outdated.rawValue])
        default: return   NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.failed.rawValue])
        }
        return nil
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 12)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters):
                
                try configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestArrayParametersAndHeaders(let bodyArrayParameters,
                                              let bodyEncoding,
                                              let urlParameters):
                
                try configureArrayParameters(bodyArrayParameters: bodyArrayParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
                
                
            case .requestHeaders(let bodyEncoding):
                
                try configureParameters(bodyParameters: nil,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: nil,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         imageTuple: (UIImage?, String)? = nil,
                                         request: inout URLRequest) throws {
        do {
            
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters, imageTuple: imageTuple)
        } catch {
            throw error
        }
    }
    
    
    fileprivate func configureArrayParameters(bodyArrayParameters: ArrayParameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         imageTuple: (UIImage?, String)? = nil,
                                         request: inout URLRequest) throws {
        do {
            
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: nil, bodyArrayParameters: bodyArrayParameters, urlParameters: urlParameters, imageTuple: imageTuple)
        } catch {
            throw error
        }
    }

}
