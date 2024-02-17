//
//  PropertiesResponse.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

struct PropertiesResponse {
    let properties: [CityProperty]
    let error: Error?
}


struct PropertyScreenResponse {
    let property: SingleProperty?
    let error: Error?
}
