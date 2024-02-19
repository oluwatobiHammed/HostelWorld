//
//  NetworkingManagerTests.swift
//  HostelWorldTests
//
//  Created by Oladipupo Oluwatobi on 19/02/2024.
//

import XCTest
@testable import HostelWorld

final class NetworkingManagerTests: XCTestCase {

    private var session: URLSession!
    private var url: URL!
    private var router: Router<HWEndpoints>!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        router = Router<HWEndpoints>()
        url = URL(string: kAPI.Base_URL)?.appendingPathComponent(HWEndpoints.getCityProperties.path)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        url = nil
    }

    func test_with_successful_response_response_is_valid() async throws {
        
        guard let path = Bundle.main.path(forResource: "PropertyList", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let (newdata, newresponse, error) =  await router.request(.getCityProperties)
        
        let res = try! CityProperties.decode(data: newdata!)
        let staticJSON =  LocalJSONDecoder().decode(CityProperties.self, fromFileNamed: "PropertyList")
        
        XCTAssertEqual(res.properties.first?.name, staticJSON?.properties.first?.name, "The returned response should be decoded properly")
    }
    
    func test_with_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
            let (newdata, newresponse, error) =  await router.request(.getCityProperties)
            
            let networkingError = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue])
           
            
            XCTAssertEqual(networkingError,
                           NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue]),
                           "Error should be a networking error which throws an invalid status code")
            
        
    }

}
