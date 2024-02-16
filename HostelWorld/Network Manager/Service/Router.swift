//
//  Router.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

// Enum defining possible network responses with associated error messages.
enum NetworkResponse: String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case unableToConvertToImage = "We could not convert response data to an image."
}


// Enum defining a generic result type for representing success or failure of an operation.
enum Result<Error> {
    case success
    case failure(Error)
}


protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint) async -> (Data?,URLResponse?, Error?)
}


class Router<EndPoint: EndPointType>: NetworkRouter {
    
    // URLSession to perform network requests.
    private let session = URLSession(configuration: .default)
    
    // URLSessionTask to keep track of the ongoing request.
    private var task: URLSessionTask?
    
    // Flag indicating whether debug mode is enabled.
    private var isDebugModeEnabled: Bool = {
        guard let debugModeState = Bundle.main.object(forInfoDictionaryKey: "DebugModeState") as? NSString, debugModeState.boolValue else {
            return false
        }
        return debugModeState.boolValue
    }()
    
    // Implementation of the network request using async/await.
    func request(_ route: EndPoint) async -> (Data?, URLResponse?, Error?) {
        do {
            // Build the URLRequest based on the provided endpoint.
            let request = try buildRequest(from: route)
            // Log the outgoing network request if debug mode is enabled.
            NetworkLogger.log(request: request)
            // Perform the network request and await the result.
            let (data, response) = try await session.data(for: request)
            
            // Validate the response and handle errors.
            guard let response = response as? HTTPURLResponse else {
                return (nil, nil, handleNetworkResponse(HTTPURLResponse()))
            }
            
            return (data, response, handleNetworkResponse(response))
        } catch {
            // Return any errors encountered during the process.
            return (nil, nil, error)
        }
    }
    
    // Handle network response based on HTTP status codes.
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Error? {
        switch response.statusCode {
        case 200...299: break
        case 404: break
        case 401...500:
            return NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.authenticationError.rawValue])
        case 501...599:
            return NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.badRequest.rawValue])
        case 600:
            return NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.outdated.rawValue])
        default:
            return NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.failed.rawValue])
        }
        return nil
    }
    
    // Build URLRequest based on the provided endpoint.
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 12)
        
        // Set HTTP method.
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            // Configure parameters based on the task associated with the endpoint.
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters,
                                         bodyEncoding: bodyEncoding,
                                         urlParameters: urlParameters,
                                         request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters,
                                         bodyEncoding: bodyEncoding,
                                         urlParameters: urlParameters,
                                         request: &request)
                
            case .requestArrayParametersAndHeaders(let bodyArrayParameters, let bodyEncoding, let urlParameters):
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
    
    // Configure parameters for the URLRequest.
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    // Configure array parameters for the URLRequest.
    fileprivate func configureArrayParameters(bodyArrayParameters: ArrayParameters?,
                                              bodyEncoding: ParameterEncoding,
                                              urlParameters: Parameters?,
                                              request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: nil, bodyArrayParameters: bodyArrayParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
}

