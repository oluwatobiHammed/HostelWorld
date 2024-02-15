//
//  PropertiseViewModel.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

class PropertiesViewModel: ObservableObject {
    
    @Published var properties: CityProperties?
    let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    func getProperties() async -> CityProperties?  {
        
        let result = await network.getCityProperties()
        switch result {
            
        case .failure(let error):
           return nil
        case .success(let propertise):
           return propertise
            
        }
        
    }
}
