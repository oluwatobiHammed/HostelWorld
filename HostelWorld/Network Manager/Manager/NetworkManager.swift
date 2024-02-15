//
//  NetworkManager.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

struct NetworkManager: NetworkManagerProtocol {
    
    
    func getCityProperties() {
        let (data, response, error) = await router.request(.postSurveyAnswer(answers: answers))
    }
    
    func getProperty(id: Int) {
        
    }
    
}
