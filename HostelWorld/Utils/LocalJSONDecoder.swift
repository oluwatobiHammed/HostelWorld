//
//  LocalJSONDecoder.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import Foundation

class LocalJSONDecoder {
    
    
    func decode<T: Decodable>(_ type: T.Type, fromFileNamed fileName: String, fileExtension: String = "json") -> T? {
        // URL of the JSON file
        let jsonFileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        
        if let jsonFileURL {
            do {
                // Read the JSON data from the file
                let jsonData = try Data(contentsOf: jsonFileURL)
                
                // Decode the JSON data into your custom Swift type
                guard  let decodedData = try? T.decode(data: jsonData) else {return nil}
                return decodedData
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
