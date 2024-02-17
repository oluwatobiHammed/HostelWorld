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
    
    @Published var isLoading: Bool = false
    
    @Published var images: [PropertyImage] = []
    
    // Instance of a NetworkManager conforming to NetworkManagerProtocol.
    private let network: NetworkManagerProtocol
    
    // Initializer with a default NetworkManager if one is not provided.
    init(network: NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    // Asynchronously fetch city properties and update the properties variable.
   @MainActor func getProperties() async   {
       isLoading = true
        if let cityProperty = HWRealmManager.shared.cityProperties, !cityProperty.isInvalidated, !cityProperty.properties.isEmpty {
            let result = Array(cityProperty.properties)
            properties = PropertiesResponse(properties: result, error: nil)
            isLoading = false
        } else {
            // Make an asynchronous network request to get city properties.
            let result = await network.getCityProperties()
            
            // Process the result of the network request.
            switch result {
            case .failure(let error):
                // If there is a network error, return a PropertiesResponse with the error.
                properties = PropertiesResponse(properties: [], error: error)
                isLoading = false
            case .success(let properties):
                // If the network request is successful, return a PropertiesResponse with the fetched properties.
                guard let result = properties?.properties else {return}
                let propertyList = Array(result)
                self.properties = PropertiesResponse(properties: propertyList, error: nil)
                isLoading = false
            }
        }
        
    }
    
    // Asynchronously fetch city properties and update the properties variable.
    @MainActor func getProperty(id: String) async  {
        isLoading = false
        if let property = HWRealmManager.shared.fetchProperty(forID: id), !property.isInvalidated {
            isLoading = false
            self.property = PropertyScreenResponse(property: property, error: nil)
            images = Array(property.images)
        } else {
            
            // Make an asynchronous network request to get Property.
            let result = await network.getProperty(id: id)
            
            // Process the result of the network request.
            switch result {
            case .failure(let error):
                // If there is a network error, return a PropertyScreenResponse with the error.
                isLoading = false
                property = PropertyScreenResponse(property: nil, error: error)
                
            case .success(let property):
                // If the network request is successful, return a PropertyScreenResponse with the fetched properties.
                isLoading = false
                self.property =  PropertyScreenResponse(property: property, error: nil)
                if let propertyimages = property?.images {
                    images = Array(propertyimages)
                }
            }
        }
 
     }
    
    @MainActor func memoryCleanUp() {
        HWRealmManager.shared.clearObject(type: CityProperties.self)
        HWRealmManager.shared.clearObject(type: SingleProperty.self)
    }
}

