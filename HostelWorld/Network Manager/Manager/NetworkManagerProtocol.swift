//
//  NetworkManagerProtocol.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func  getCityProperties() async ->  ResultApi<CityProperties, Error>
    func  getProperty(id: Int) async -> ResultApi<SingleProperty, Error>
}


extension NetworkManagerProtocol {
    
    var isDebugModeEnabled: Bool {
        get {
            guard let debugModeState = Bundle.main.object(forInfoDictionaryKey: "DebugModeState") as? NSString, debugModeState.boolValue else {
                return false
            }
            return debugModeState.boolValue
        }
    }
    
    var router: Router<B2BEndpoints> {
        return Router<B2BEndpoints>()
    }
}
