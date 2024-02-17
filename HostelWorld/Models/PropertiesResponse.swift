//
//  PropertiesResponse.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

struct PropertiesResponse: Equatable {
    static func == (lhs: PropertiesResponse, rhs: PropertiesResponse) -> Bool {
        // Compare properties array
            let propertiesEqual = lhs.properties == rhs.properties
            
            // Compare error properties using optional chaining and nil-coalescing operator
            let errorEqual: Bool
            switch (lhs.error, rhs.error) {
            case (.some(let lhsError), .some(let rhsError)):
                errorEqual = lhsError.localizedDescription == rhsError.localizedDescription
            case (nil, nil):
                errorEqual = true
            default:
                errorEqual = false
            }
            
            return propertiesEqual && errorEqual
    }

    let properties: [CityProperty]
    let error: Error?
}


struct PropertyScreenResponse: Equatable {
    
    static func == (lhs: PropertyScreenResponse, rhs: PropertyScreenResponse) -> Bool {
        // Compare properties array
            let propertiesEqual = lhs.property == rhs.property
            
            // Compare error properties using optional chaining and nil-coalescing operator
            let errorEqual: Bool
            switch (lhs.error, rhs.error) {
            case (.some(let lhsError), .some(let rhsError)):
                errorEqual = lhsError.localizedDescription == rhsError.localizedDescription
            case (nil, nil):
                errorEqual = true
            default:
                errorEqual = false
            }
            
            return propertiesEqual && errorEqual
    }
    let property: SingleProperty?
    let error: Error?
}
