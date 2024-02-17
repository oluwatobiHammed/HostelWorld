//
//  PropertiseViewModel.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

// ViewModel class responsible for managing properties data and handling network interactions.
class PropertiesViewModel: ObservableObject {
    
    // Published property to trigger updates when the properties data changes.
    @Published var properties: PropertiesResponse?
    
    // Published property to trigger updates when the properties data changes.
    @Published var property: PropertyScreenResponse?
    
    @Published var isLoading: Bool = true
    
    // Instance of a NetworkManager conforming to NetworkManagerProtocol.
    private let network: NetworkManagerProtocol
    
    // Initializer with a default NetworkManager if one is not provided.
    init(network: NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    // Asynchronously fetch city properties and update the properties variable.
   @MainActor func getProperties() async -> PropertiesResponse  {
        
        if let cityProperty = HWRealmManager.shared.cityProperties, !cityProperty.isInvalidated, !cityProperty.properties.isEmpty {
            let result = Array(cityProperty.properties)
            return PropertiesResponse(properties: result, error: nil)
        } else {
            // Make an asynchronous network request to get city properties.
            let result = await network.getCityProperties()
            
            // Process the result of the network request.
            switch result {
            case .failure(let error):
                // If there is a network error, return a PropertiesResponse with the error.
                return PropertiesResponse(properties: [], error: error)
                
            case .success(let properties):
                // If the network request is successful, return a PropertiesResponse with the fetched properties.
                guard let result = properties?.properties else {return  PropertiesResponse(properties: [], error: nil) }
                let propertyList = Array(result)
                return PropertiesResponse(properties: propertyList, error: nil)
            }
        }
        
    }
    
    // Asynchronously fetch city properties and update the properties variable.
    @MainActor func getProperty(id: String) async -> PropertyScreenResponse  {
        if let property = HWRealmManager.shared.fetchProperty(forID: id), !property.isInvalidated {
            
            return PropertyScreenResponse(property: property, error: nil)
            
        } else {
            
            // Make an asynchronous network request to get Property.
            let result = await network.getProperty(id: id)
            
            // Process the result of the network request.
            switch result {
            case .failure(let error):
                // If there is a network error, return a PropertyScreenResponse with the error.
                return PropertyScreenResponse(property: nil, error: error)
                
            case .success(let property):
                // If the network request is successful, return a PropertyScreenResponse with the fetched properties.
                return PropertyScreenResponse(property: property, error: nil)
            }
        }
 
     }
    
    @MainActor func memoryCleanUp() {
        HWRealmManager.shared.clearObject(type: CityProperties.self)
        HWRealmManager.shared.clearObject(type: SingleProperty.self)
    }
}

