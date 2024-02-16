//
//  NetworkManagerProtocol.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

// Protocol defining the contract for a network manager.
protocol NetworkManagerProtocol {
    func getCityProperties() async -> ResultApi<CityProperties, Error>
    func getProperty(id: Int) async -> ResultApi<SingleProperty, Error>
}



// Extension providing default implementations and computed properties for the network manager.
extension NetworkManagerProtocol {
    // Computed property to determine if debug mode is enabled.
    var isDebugModeEnabled: Bool {
        get {
            guard let debugModeState = Bundle.main.object(forInfoDictionaryKey: "DebugModeState") as? NSString, debugModeState.boolValue else {
                return false
            }
            return debugModeState.boolValue
        }
    }

    // Computed property returning a default router instance for HWEndpoints.
    var router: Router<HWEndpoints> {
        return Router<HWEndpoints>()
    }
}

