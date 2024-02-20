//
//  PropertyListHomePageTest.swift
//  HostelWorldTests
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import XCTest
@testable import HostelWorld

// Import necessary testing frameworks

@MainActor
class PropertyListViewModelTest: XCTestCase {
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
    
    // Test the asynchronous fetching of city properties when the request is successful
    func testgetCityPropertiesSuccess() async  {
        // Set the file name for the mock response data
        service.fileName = "PropertyList"
        
        await self.viewModel.getProperties()
        XCTAssertTrue(!(viewModel.properties?.properties.isEmpty ?? false))
        XCTAssertNil(viewModel.properties?.error)
        XCTAssertEqual(viewModel.properties?.properties.count, 19) // Replace 19 with your expected property count
        
    }
    
    // Test the asynchronous fetching of city properties when the request fails
    func testgetCityPropertiesFailed() async  {
        
        // Fetch city properties and assert the expected results
        await viewModel.getProperties()
        XCTAssertNotNil(viewModel.properties?.error)
        XCTAssertTrue((viewModel.properties?.properties.isEmpty ?? false))
        XCTAssertEqual(viewModel.properties?.properties.count, 0)
        //XCTAssertEqual(viewModel.errorMessage, viewModel.properties?.error?.localizedDescription, "errorMessage value need to be equal to network error message")
        
    }
    
    // Test the asynchronous fetching of city properties when the request fails
    func testgetCityPropertiesLoadsProperlly() async  {
        
        service.fileName = "PropertyList"
        XCTAssertTrue(!viewModel.isLoading)
        
        // Fetch city properties and assert the expected results
        await viewModel.getProperties()
        XCTAssertEqual(viewModel.properties?.properties.count, 19) // Replace 19 with your expected property count
        
    }
 
}

