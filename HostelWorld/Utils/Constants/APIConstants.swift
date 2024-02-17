//
//  APIConstants.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

// Struct encapsulating API-related information.
struct kAPI {
    // The base URL for the API.
    static let Base_URL = "http://private-anon-7bfd3141f6-practical3.apiary-mock.com"

    // Nested struct defining specific endpoints for the API.
    struct Endpoints {
        // Endpoint for retrieving city properties.
        static let city = "/cities/1530/properties/"

        // Endpoint for retrieving a specific property.
        static let property = "/properties/"
    }
}

