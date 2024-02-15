//
//  NetworkManager.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

struct NetworkManager: NetworkManagerProtocol {
    
    
    func getCityProperties() async ->  ResultApi<CityProperties, Error>{
        let (data, response, error) = await router.request(.getCityProperties)
        
        if error != nil {
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
        
        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response)
            switch result {
            case .success:
                
                guard let responseData = data else {
                    return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.noData.rawValue]))
                    
                }
                do {
                    
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    if isDebugModeEnabled { print(jsonData) }
                    
                    guard let properties = try? CityProperties.decode(data: responseData) else {
                        return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                    }
                    //print(properties)
                    
                    return .success(properties)
                } catch {
                        
                        
                        return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                    
                }
            case .failure(let networkFailureError):
                return .failure(networkFailureError)
            }
        } else {
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
    }
    
    func getProperty(id: Int) async ->  ResultApi<SingleProperty, Error>  {
        let (data, response, error) = await router.request(.getProperty(id: id))
        
        if error != nil {
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
        
        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response)
            switch result {
            case .success:
                
                guard let responseData = data else {
                    return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.noData.rawValue]))
                    
                }
                do {
                    
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    if isDebugModeEnabled { print(jsonData) }
                    
                    guard let property = try? SingleProperty.decode(data: responseData) else {
                        return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                    }
                    
                    return .success(property)
                } catch {
                    
                    if response.statusCode == 200 {
                        return .failure(nil)
                    } else {
                        
                        
                        return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                    }
                }
            case .failure(let networkFailureError):
                return .failure(networkFailureError)
            }
        } else {
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Error>{
       switch response.statusCode {
       case 200...299: return .success
       case 404: return .success
       case 401...500: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.authenticationError.rawValue]))
       case 501...599: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.badRequest.rawValue]))
       case 600: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.outdated.rawValue]))
       default: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.failed.rawValue]))
       }
   }
    
}


enum ResultApi<Value, ErrorType> {
    case success(Value?)
    case failure(ErrorType?)
}
