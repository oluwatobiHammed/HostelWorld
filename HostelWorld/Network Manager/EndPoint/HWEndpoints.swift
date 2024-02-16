//
//  B2BEndpoints.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

// Enumeration defining different endpoints for the network API.
enum HWEndpoints {
    case getCityProperties
    case getProperty(id: Int)
}

// Extension providing conformance to the EndPointType protocol.
extension HWEndpoints: EndPointType {
    // Computed property to specify the base URL for the endpoint.
    var baseURL: URL {
        guard let url = URL(string: kAPI.Base_URL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    // Computed property to specify the path for the endpoint based on the case.
    var path: String {
        switch self {
        case .getCityProperties:
            return kAPI.Endpoints.city
        case .getProperty(let id):
            return kAPI.Endpoints.property + "\(id)"
        }
    }

    // Computed property to specify the HTTP method for the endpoint based on the case.
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    // Computed property to specify the task for the endpoint based on the case.
    var task: HTTPTask {
        switch self {
        case .getCityProperties, .getProperty(_):
            return .requestHeaders(bodyEncoding: .urlEncoding)
        }
    }
}

