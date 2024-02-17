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
    }
    
    // Test the asynchronous fetching of city properties when the request is successful
    func testgetCityPropertiesSuccess()  {
        // Set the file name for the mock response data
        service.fileName = "PropertyList"
        let expectation = XCTestExpectation(description: "Get Property List")
        Task {
            // Fetch city properties and assert the expected results
            await self.viewModel.getProperties()
            XCTAssertTrue(!(viewModel.properties?.properties.isEmpty ?? false))
            XCTAssertNil(viewModel.properties?.error)
            XCTAssertEqual(viewModel.properties?.properties.count, 19) // Replace 19 with your expected property count
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
    
    // Test the asynchronous fetching of city properties when the request fails
    func testgetCityPropertiesFailed()  {
        let expectation = XCTestExpectation(description: "Get Empty Property List and Error message")
        Task {
            // Fetch city properties and assert the expected results
            await viewModel.getProperties()
            XCTAssertNotNil(viewModel.properties?.error)
            XCTAssertTrue((viewModel.properties?.properties.isEmpty ?? false))
            XCTAssertEqual(viewModel.properties?.properties.count, 0)
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
    
    // Test the asynchronous fetching of a property when the request is successful
    func testgetPropertySuccessFul()  {
        // Set the file name for the mock response data
        service.fileName = "Property"
        let expectation = XCTestExpectation(description: "Get Property")
        Task {
            // Fetch a property and assert the expected results
             await viewModel.getProperty(id: "80771")
            XCTAssertNotNil(viewModel.property?.property)
            XCTAssertNil(viewModel.property?.error)
            XCTAssertEqual(viewModel.property?.property?.name, "Linnéplatsens Hotel & Hostel")
            XCTAssertEqual(viewModel.property?.property?.id, "80771")
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
    
    // Test the asynchronous fetching of a property when the request fails
    func testgetPropertyFailed()  {
        let expectation = XCTestExpectation(description: "Get Empty Property and Error message")
        Task {
            // Fetch a property and assert the expected results
            await viewModel.getProperty(id: "80771")
            XCTAssertNil(viewModel.property?.property)
            XCTAssertNotNil(viewModel.property?.error)
            XCTAssertNotEqual(viewModel.property?.property?.name, "Linnéplatsens Hotel & Hostel")
            XCTAssertNotEqual(viewModel.property?.property?.id, "80771")
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
    
    // Test the asynchronous fetching of a property when the ID is not provided
    func testgetPropertyFailedWhenIdisNotProvided()  {
        let expectation = XCTestExpectation(description: "Get Empty Property and Error message")
        Task {
            // Fetch a property with an empty ID and assert the expected results
            await viewModel.getProperty(id: "")
            XCTAssertNil(viewModel.property?.property)
            XCTAssertNotNil(viewModel.property?.error)
            XCTAssertNotEqual(viewModel.property?.property?.name, "Linnéplatsens Hotel & Hostel")
            XCTAssertNotEqual(viewModel.property?.property?.id, "80771")
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled (with a timeout if necessary)
        wait(for: [expectation], timeout: 3)
    }
}

