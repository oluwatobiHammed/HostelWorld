//
//  NetworkLogger.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import Foundation

class NetworkLogger {
    // Static method for logging outgoing network requests.
    static func log(request: URLRequest) {
        // Check if debug mode is enabled before logging.
        guard let debugModeState = Bundle.main.object(forInfoDictionaryKey: "DebugModeState") as? NSString, debugModeState.boolValue else {
            return
        }
        
        // Print a header for the outgoing request log.
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        // Use 'defer' to print a footer at the end, ensuring it always executes.
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        // Extract relevant information from the URLRequest for logging.
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod ?? ""
        let path = urlComponents?.path ?? ""
        let query = urlComponents?.query ?? ""
        let host = urlComponents?.host ?? ""
        
        // Construct the log output with request details.
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        // Include headers in the log output.
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        // Include the request body in the log output if present.
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        // Print the final log output.
        print(logOutput)
    }
    
    // Static method for logging network responses (placeholder).
    static func log(response: URLResponse) {
        // This method can be extended to log response details if needed.
    }
}


