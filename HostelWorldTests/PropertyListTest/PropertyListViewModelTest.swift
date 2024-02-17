//
//  PropertyListHomePageTest.swift
//  HostelWorldTests
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import XCTest
@testable import HostelWorld
@MainActor
class PropertyListViewModelTest: XCTestCase {
    var viewModel: PropertiesViewModel!
    var service: NetworkManagerMock!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = NetworkManagerMock()
        viewModel = PropertiesViewModel(network: service)
        // Simulate network response with expected data or error
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertEqual(viewModel.properties, nil)
        XCTAssertEqual(viewModel.property, nil)
    }
    
    
     func testgetCityPropertiesSuccess()  {
         // Create a mock NetworkManager that returns expected results
        service.fileName = "PropertyList"
         let expectation = XCTestExpectation(description: "Get Property List")
        Task {
            let result = await viewModel.getProperties()
            // Assert the behavior of your view model based on the expected results
            XCTAssertTrue(!result.properties.isEmpty)
            XCTAssertNil(result.error)
             XCTAssertEqual(result.properties.count, 19) // Replace 19 with your expected prompt count
             expectation.fulfill()
        }
      
         // Wait for the expectation to be fulfilled (with a timeout if necessary)
         wait(for: [expectation], timeout: 3)
     }
    
    func testgetCityPropertiesFailed()  {
        // Create a mock NetworkManager that returns expected results
        
        let expectation = XCTestExpectation(description: "Get Empty Property List and Error message")
       Task {
           let result = await viewModel.getProperties()
           // Assert the behavior of your view model based on the expected results
           XCTAssertNotNil(result.error)
           XCTAssertTrue(result.properties.isEmpty)
            XCTAssertEqual(result.properties.count, 0)
            expectation.fulfill()
       }
     
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
    
    func testgetPropertySuccessFul()  {
        // Create a mock NetworkManager that returns expected results
        service.fileName = "Property"
        let expectation = XCTestExpectation(description: "Get Property")
        Task {
            
            let result = await viewModel.getProperty(id: "80771")
            // Assert the behavior of your view model based on the expected results
            XCTAssertNotNil(result.property)
            XCTAssertNil(result.error)
            XCTAssertEqual(result.property?.name, "Linnéplatsens Hotel & Hostel")
            XCTAssertEqual(result.property?.id, "80771")
            expectation.fulfill()
       
       }
        
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
    
    func testgetPropertyFailed()  {
        // Create a mock NetworkManager that returns expected results
        let expectation = XCTestExpectation(description: "Get Empty Property and Error message")
        Task {
            
            let result = await viewModel.getProperty(id: "80771")
            // Assert the behavior of your view model based on the expected results
            XCTAssertNil(result.property)
            XCTAssertNotNil(result.error)
            XCTAssertNotEqual(result.property?.name, "Linnéplatsens Hotel & Hostel")
            XCTAssertNotEqual(result.property?.id, "80771")
            expectation.fulfill()
       
       }
        
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
    
    func testgetPropertyFailedWhenIdisNotProvided()  {
        // Create a mock NetworkManager that returns expected results
        let expectation = XCTestExpectation(description: "Get Empty Property and Error message")
        Task {
            
            let result = await viewModel.getProperty(id: "")
            // Assert the behavior of your view model based on the expected results
            XCTAssertNil(result.property)
            XCTAssertNotNil(result.error)
            XCTAssertNotEqual(result.property?.name, "Linnéplatsens Hotel & Hostel")
            XCTAssertNotEqual(result.property?.id, "80771")
            expectation.fulfill()
       
       }
        
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
}
