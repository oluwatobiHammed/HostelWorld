//
//  NetworkManager.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

struct NetworkManager: NetworkManagerProtocol {
    
    
    /**
     This asynchronous function, `getCityProperties`, is responsible for retrieving city properties data from the network using the provided router's `.getCityProperties` endpoint. It returns a ResultApi<CityProperties, Error> to handle success and failure cases.

     - Returns: A ResultApi encapsulating either the successfully decoded `CityProperties` or an `Error` indicating the failure. In case of a network error, it provides a custom error message specifying the need to check the network connection.

     The function utilizes Swift's async/await pattern for asynchronous network requests. It first awaits the result of the network request using the provided router. If an error is encountered during the network request, it immediately returns a failure result with a custom NSError containing a descriptive message about checking the network connection.

     If the network request is successful, it checks the HTTPURLResponse and utilizes a function, `handleNetworkResponse`, to determine whether the response indicates success or failure. In case of a successful response, it attempts to decode the received data into `CityProperties` using a custom decoding method. If decoding is successful, it returns a success result with the decoded `CityProperties`. If any step fails, it returns a failure result with a relevant NSError containing an appropriate error message.

     - Note: This function assumes the existence of a router with appropriate endpoints and a `handleNetworkResponse` function to evaluate the success or failure of the network response. Additionally, it uses a custom decoding method (`CityProperties.decode`) for decoding the received data into the expected model.

     - Parameters: None

     - Throws: None

     - Example usage:
       ```swift
       do {
           let result = try await getCityProperties()
           switch result {
           case .success(let cityProperties):
               // Handle successful response with city properties
               print(cityProperties)
           case .failure(let error):
               // Handle failure with the provided error
               print("Error: \(error.localizedDescription)")
           }
       } catch {
           // Handle other errors during the asynchronous execution
           print("Unexpected error: \(error)")
       }
     */
    func getCityProperties() async ->  ResultApi<CityProperties, Error>{
        // Make an asynchronous request to fetch city properties using the router.
        let (data, response, error) = await router.request(.getCityProperties)
        
        // Check if there is an error.
        if error != nil {
            // If there is an error, return a failure ResultApi with a descriptive error message.
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
        
        // If there is a response, attempt to process it.
        if let response = response as? HTTPURLResponse {
            // Handle the network response.
            let result = handleNetworkResponse(response)
            
            switch result {
            case .success:
                // If the network response is successful, proceed to handle the received data.
                guard let responseData = data else {
                    // If there is no data, return a failure ResultApi with a relevant error message.
                    return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.noData.rawValue]))
                }
                
                do {
                    // Deserialize the JSON data received from the network.
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    if isDebugModeEnabled {
                        // If debug mode is enabled, print the JSON data.
                        print(jsonData)
                    }
                    
                    // Attempt to decode the received data into CityProperties model.
                    guard let properties = try? CityProperties.decode(data: responseData) else {
                        // If unable to decode, return a failure ResultApi with an appropriate error message.
                        return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                    }
                    
                    // Return a success ResultApi containing the decoded CityProperties.
                    return .success(properties)
                } catch {
                    // If an error occurs during JSON deserialization or decoding, return a failure ResultApi with an appropriate error message.
                    return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                }
            case .failure(let networkFailureError):
                // If the network response indicates a failure, return a failure ResultApi with the corresponding error.
                return .failure(networkFailureError)
            }
        } else {
            // If there is no valid HTTPURLResponse, return a failure ResultApi with a descriptive error message.
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
    }
    
    
    /**
     This asynchronous function, `getProperty`, is responsible for fetching data for a single property with the specified identifier from the network using the provided router's `.getProperty(id:)` endpoint. It returns a `ResultApi<SingleProperty, Error>` to handle both successful data retrieval and potential failures.

     - Parameter id: The unique identifier of the property for which data needs to be fetched.

     - Returns: A `ResultApi` encapsulating either the successfully decoded `SingleProperty` or an `Error` indicating a failure. In case of a network error, a custom `NSError` is included with a descriptive message prompting users to check their network connection.

     The function employs Swift's async/await pattern for asynchronous network requests. It awaits the result of the network request via the provided router, checking for errors along the way. In the event of a network error, it returns a failure result with a custom `NSError` conveying a clear message about the necessity to inspect the network connection.

     If the network request is successful, the function inspects the `HTTPURLResponse` using a function called `handleNetworkResponse`. This function helps determine whether the response indicates success or failure. Upon receiving a successful response, the function attempts to decode the received data into `SingleProperty` using a custom decoding method (`SingleProperty.decode`). If the decoding is successful, it returns a success result with the decoded `SingleProperty`. Any failure during these steps results in a failure result with an appropriate `NSError` containing an informative error message.

     Additionally, the function handles a specific scenario where, despite a successful network request (status code 200), decoding the response data may fail. In such cases, it returns a failure result with an appropriate `NSError`.

     - Note: This function assumes the existence of a router with the required endpoints, a `handleNetworkResponse` function to evaluate the success or failure of the network response, and a custom decoding method (`SingleProperty.decode`) for converting the received data into the expected model.

     - Throws: None

     - Example usage:
       ```swift
       do {
           let result = try await getProperty(id: 123)
           switch result {
           case .success(let singleProperty):
               // Handle a successful response with the single property data
               print(singleProperty)
           case .failure(let error):
               // Handle a failure with the provided error
               if let error = error {
                   print("Error: \(error.localizedDescription)")
               } else {
                   // Handle a scenario where decoding fails despite a successful network request
                   print("Unable to decode the response data.")
               }
           }
       } catch {
           // Handle other errors during asynchronous execution
           print("Unexpected error: \(error)")
       }
     */
    
    func getProperty(id: Int) async ->  ResultApi<SingleProperty, Error>  {
        // Make an asynchronous request to fetch a property with the given ID using the router.
        let (data, response, error) = await router.request(.getProperty(id: id))
        
        // Check if there is an error.
        if error != nil {
            // If there is an error, return a failure ResultApi with a descriptive error message.
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
        
        // If there is a response, attempt to process it.
        if let response = response as? HTTPURLResponse {
            // Handle the network response.
            let result = handleNetworkResponse(response)
            
            switch result {
            case .success:
                // If the network response is successful, proceed to handle the received data.
                guard let responseData = data else {
                    // If there is no data, return a failure ResultApi with a relevant error message.
                    return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.noData.rawValue]))
                }
                
                do {
                    // Deserialize the JSON data received from the network.
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    
                    // If debug mode is enabled, print the JSON data.
                    if isDebugModeEnabled { print(jsonData) }
                    
                    // Attempt to decode the received data into SingleProperty model.
                    guard let property = try? SingleProperty.decode(data: responseData) else {
                        // If unable to decode, return a failure ResultApi with an appropriate error message.
                        return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                    }
                    
                    // Return a success ResultApi containing the decoded SingleProperty.
                    return .success(property)
                } catch {
                    // Handle cases where decoding is not successful.
                    if response.statusCode == 200 {
                        // If the response status code is 200 but decoding fails, return a failure ResultApi with nil.
                        return .failure(nil)
                    } else {
                        // If an error occurs during JSON deserialization or decoding, return a failure ResultApi with an appropriate error message.
                        return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]))
                    }
                }
            case .failure(let networkFailureError):
                // If the network response indicates a failure, return a failure ResultApi with the corresponding error.
                return .failure(networkFailureError)
            }
        } else {
            // If there is no valid HTTPURLResponse, return a failure ResultApi with a descriptive error message.
            return .failure(NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."]))
        }
    }
    
    // Handles the HTTP network response and determines the result based on the status code.
   private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Error> {
        switch response.statusCode {
        case 200...299:
            // Success range: 200 to 299 (inclusive) and 404 (treated as success).
            return .success
        case 401...500:
            // Authentication error range: 401 to 500.
            return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.authenticationError.rawValue]))
        case 501...599:
            // Bad request error range: 501 to 599.
            return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.badRequest.rawValue]))
        case 600:
            // Outdated error: 600.
            return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.outdated.rawValue]))
        default:
            // Any other status code is treated as a general failure.
            return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.failed.rawValue]))
        }
    }

    
}


// Enumeration representing the result of an API operation.
enum ResultApi<Value, ErrorType> {
    // Represents a successful result with an optional associated value.
    case success(Value?)
    
    // Represents a failure result with an optional associated error.
    case failure(ErrorType?)
}
