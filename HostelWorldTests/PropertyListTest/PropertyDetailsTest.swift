//
//  PropertyDetailsTest.swift
//  HostelWorldTests
//
//  Created by Oladipupo Oluwatobi on 19/02/2024.
//

import XCTest
@testable import HostelWorld

// Import necessary testing frameworks

@MainActor
class PropertyDetailsTest: XCTestCase {
    // Declare variables for testing
    var viewModel: PropertiesViewModel!
    var service: NetworkManagerMock!
    
    // Set up the initial conditions before each test method
    override func setUp() {
        super.setUp()
        // Create a mock NetworkManager and initialize the PropertiesViewModel with it
        service = NetworkManagerMock()
        viewModel = PropertiesViewModel(network: service)
        // Additional setup code can be added if needed
    }
    
    // Clean up after each test method
    override func tearDown() {
        // Deallocate resources and set variables to nil
        service = nil
        viewModel = nil
        super.tearDown()
    }
    
    // Test the initialization of PropertiesViewModel
    func testInitialization() {
        XCTAssertEqual(viewModel.properties, nil)
        XCTAssertEqual(viewModel.property, nil)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // Test the asynchronous fetching of a property when the request is successful
    func testgetPropertySuccessFul() async  {
        // Set the file name for the mock response data
        service.fileName = "Property"
        
        // Fetch a property and assert the expected results
        await viewModel.loadProperty(id: "80771")
        XCTAssertNotNil(viewModel.property?.property)
        XCTAssertNil(viewModel.property?.error)
        XCTAssertEqual(viewModel.property?.property?.name, "Linnéplatsens Hotel & Hostel")
        XCTAssertEqual(viewModel.property?.property?.id, "80771")
        
    }
    
    // Test the asynchronous fetching of a property when the request fails
    func testgetPropertyFailed() async   {
  
            await viewModel.loadProperty(id: "80771")
            XCTAssertNil(viewModel.property?.property)
            XCTAssertNotNil(viewModel.property?.error)
            XCTAssertNil(viewModel.property?.property?.name)
            XCTAssertNil(viewModel.property?.property?.id)
  
    }
    
    // Test the asynchronous fetching of a property when the ID is not provided
    func testgetPropertyFailedWhenIdisNotProvided() async throws {
        let expectation = XCTestExpectation(description: "Get Empty Property and Error message")
        
        // Fetch a property with an empty ID and assert the expected results
        await viewModel.loadProperty(id: "")
        XCTAssertNil(viewModel.property?.property)
        XCTAssertNotNil(viewModel.property?.error)
        XCTAssertNil(viewModel.property?.property?.name)
        XCTAssertNil(viewModel.property?.property?.id)
        expectation.fulfill()
    }
    
    func test_with_successful_response_users_array_is_set() async throws {
        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
    
        await viewModel.loadProperty(id: "")
        XCTAssertNil(viewModel.property?.property?.name)
    }
}
