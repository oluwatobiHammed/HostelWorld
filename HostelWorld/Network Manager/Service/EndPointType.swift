//
//  EndPointType.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

// Protocol defining the requirements for an API endpoint.
protocol EndPointType {
    // The base URL for the API.
    var baseURL: URL { get }

    // The specific path for the endpoint relative to the base URL.
    var path: String { get }

    // The HTTP method for the network request (e.g., GET, POST, etc.).
    var httpMethod: HTTPMethod { get }

    // The task associated with the network request, specifying headers and body encoding.
    var task: HTTPTask { get }
}

