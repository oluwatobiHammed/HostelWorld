//
//  B2BEndpoints.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

enum B2BEndpoints {
    case getCityProperties
    case getProperty(id: Int)
}


extension B2BEndpoints: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: kAPI.Base_URL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getCityProperties:
            return kAPI.Endpoints.city
        case .getProperty(let id):
            return kAPI.Endpoints.property+"\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getCityProperties:
            return .requestHeaders(bodyEncoding: .urlEncoding)
        case .getProperty(_):
            return .requestHeaders(bodyEncoding: .urlEncoding)
        }
    }
}
