//
//  PropertiseViewModel.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation
@MainActor
// ViewModel class responsible for managing properties data and handling network interactions.
class PropertiesViewModel: ObservableObject {
    
    // Published property to trigger updates when the properties data changes.
    @Published private (set) var properties: PropertiesResponse?
    
    // Published property to trigger updates when the properties data changes.
    @Published private (set) var property: PropertyScreenResponse?
    
    @Published private (set) var isLoading: Bool = false
    
    @Published private (set) var images: [PropertyImage] = []
    
    @Published private (set) var isViewVisible = false
    
    @Published private (set) var paymentOption: [String] = []
    
    @Published var showAlert: Bool = false
    
    @Published private (set) var errorMessage: String = ""
    
    @Published private (set) var notAvailableMessage: String = ""
    
    @Published var isRefreshing: Bool = false
    
    @Published private (set) var showErrorMessage: Bool = false
    
    
    // Instance of a NetworkManager conforming to NetworkManagerProtocol.
    private let network: NetworkManagerProtocol
    
    // Initializer with a default NetworkManager if one is not provided.
    init(network: NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    // Asynchronously fetch city properties and update the properties variable.
    func getProperties() async   {
       
        if let cityProperty = HWRealmManager.shared.cityProperties, !cityProperty.isInvalidated, !cityProperty.properties.isEmpty {
            let result = Array(cityProperty.properties)
            properties = PropertiesResponse(properties: result, error: nil)
            
        } else {
            isLoading = true
            // Make an asynchronous network request to get city properties.
            let result = await network.getCityProperties()
            
            // Process the result of the network request.
            switch result {
            case .failure(let error):
                // If there is a network error, return a PropertiesResponse with the error.
                properties = PropertiesResponse(properties: [], error: error)
                
            case .success(let properties):
                // If the network request is successful, return a PropertiesResponse with the fetched properties.
                guard let properties, !properties.isInvalidated, !properties.properties.contains(where: {$0.isInvalidated}) else {return}
                let propertyList = Array(properties.properties)
                self.properties = PropertiesResponse(properties: propertyList, error: nil)
                
                // I put this here to give a feel of loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {[weak self] in
                    self?.isLoading = false
                })
            }
            
        }
        
    }
    
    // Asynchronously fetch city properties and update the properties variable.
   private func getProperty(id: String) async  {
        isLoading = true
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
                
                property = PropertyScreenResponse(property: nil, error: error)
                
            case .success(let property):
                // If the network request is successful, return a PropertyScreenResponse with the fetched properties.
                
                self.property =  PropertyScreenResponse(property: property, error: nil)
                // I put this here to give a feel of loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
                    self?.isLoading = false
                })
                
                if let property, !property.isInvalidated, !property.images.contains(where: {$0.isInvalidated}) {
                    images = Array(property.images)
                }
            }
            
        }
 
     }
    
    private func loadPropertyList() {
        Task {[weak self] in
            guard let self else {return}
             await getProperties()
            showAlert = properties?.error != nil
            errorMessage = properties?.error?.localizedDescription ?? ""
        }
    }
    
     func reload() {
        
        memoryCleanUp()
        loadPropertyList()
        // Set isRefreshing to false after data is reloaded
        self.isRefreshing = false
    }
    
    // Fetch property details using async/await
    func getProperty(id: String) {
        Task {[weak self] in
            guard let self else {return}
            await getProperty(id: id)
            
            // Update payment options based on property details
            if let paymentOption = property?.property?.paymentMethods {
                self.paymentOption = Array(paymentOption)
            }
            
            // Update visibility and display status based on API response
            isViewVisible = properties?.error == nil
            showAlert = properties?.error != nil || property?.property == nil
            errorMessage = property?.error?.localizedDescription ?? ""
            notAvailableMessage = """
                                     Oops!!
                                     Property details is Not available !
                                     """
        }
    }
    
    // Cache clean up
    func memoryCleanUp() {
        HWRealmManager.shared.clearObject(type: CityProperties.self)
        HWRealmManager.shared.clearObject(type: SingleProperty.self)
    }
}

