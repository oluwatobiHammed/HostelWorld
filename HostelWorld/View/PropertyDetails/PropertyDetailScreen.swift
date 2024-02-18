//
//  PropertyScreen.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI


/*
   The `PropertyDetailScreen` struct represents a SwiftUI view responsible for displaying detailed information about a property.
   It includes various states and UI elements to present property details such as images, rating, description, location, payment methods, and error handling.

   - Properties:
     - id: String: Identifier for the property.
     - viewModel: PropertiesViewModel: Manages the data and business logic related to properties.
     - images: [PropertyImage]: Holds property images.
     - paymentOption: [String]: Represents available payment options for the property.
     - showAlert: Bool: Indicates whether an alert should be displayed.
     - errorMessage: String: Message to be shown in case of an error.
     - notAvailableMessage: String: Message indicating unavailability of property details.
     - isViewVisible: Bool: Controls the visibility of the main view content.
   
   - Body:
     - The body contains a ZStack with a ScrollView and additional UI elements layered on top.
     - Displays property details including images, title, rating, description, location, and payment methods.
     - Handles alert presentation for error messaging.
     - Uses redaction for placeholder UI during loading state.
   
   - Private Functions:
     - getProperty(): Asynchronous function to fetch property details and update the UI accordingly.
*/
struct PropertyDetailScreen: View {
    // Property ID used to fetch details
    let id: String
    
    // ViewModel to manage property details
    @StateObject private var viewModel =  PropertiesViewModel()
    
    // State variables to manage UI elements and display status
    @State private var images: [PropertyImage] = []
    @State private var paymentOption: [String] = []
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var notAvailableMessage: String = ""
    @State private var isViewVisible = false
    
    var body: some View {
        
        ZStack {
            
            // Main content displayed in a ScrollView
            ScrollView {
                
                VStack(spacing: 0) {
                    Spacer().frame(height: 0)
                    LoadPropertyDetailsImage(images: viewModel.images, width: UIScreen.main.bounds.width - 30, height: 120)
                        .frame(width: UIScreen.main.bounds.width, height: 280)
                    
                    TitleAndSubTitleReuseableView(title: viewModel.property?.property?.type ?? "", fontSize: Font(kFont.EffraRegular.of(size: 11)))
                        .padding(.top, 10)
                    OverallRatingView(overallRating: viewModel.property?.property?.rating?.overall.value, tile: viewModel.property?.property?.name ?? "0.0")
                    Divider()
                        .frame(height: 0.3)
                        .background(Color.primary)
                        .padding(.leading, 15)
                        .padding(.trailing, 25)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    if let direction = viewModel.property?.property?.directions, !direction.isEmpty {
                        PropertyDetailsDirectionsView(direction: direction)
                    }
                    
                    if let description = viewModel.property?.property?.propertyDescription, !description.isEmpty {
                        PropertyDetailsDescriptionView(description: description, isLoading: viewModel.isLoading)
                    }
                    if let property = viewModel.property?.property, !property.isInvalidated, let address1 = viewModel.property?.property?.address1, let name = property.city?.name, let country = property.city?.country {
                        TitleAndSubTitleReuseableView(title: "Location")
                            .padding(.top, 5)
                        AddressView(address: "\(address1), \(name),  \(country)")
                    }
                    
                    if !paymentOption.isEmpty {
                        Divider()
                            .frame(height: 0.3)
                            .background(Color.primary)
                            .padding(.leading, 15)
                            .padding(.trailing, 25)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        
                        TitleAndSubTitleReuseableView(title: "Payment Method")
                            .padding(.top, 5)
                        PaymentMethodScrollView(paymentMethod: paymentOption)
                            .padding(.top, -15)
                    }
                    
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
            .alert("Something happened", isPresented: $showAlert) {
                Button("ok") {
                    // Handle OK button action
                    showAlert = false
                    
                }
            }
        message: {
            Text(errorMessage)
        }
        .onLoad {
            getProperty()
        }
            
        .navigationTitle(viewModel.property?.property?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
            
            // Display a message if the view is not visible and not loading
            if !isViewVisible, !viewModel.isLoading {
                Spacer()
                HStack {
                    Text(notAvailableMessage)
                        .multilineTextAlignment(.center) // You can adjust the alignment as needed
                        .padding()
                }
                Spacer()
            }
        }
        // Apply redacted placeholder if data is still loading
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        
    }
    
    // Fetch property details using async/await
    private func getProperty() {
        Task {
            await viewModel.getProperty(id: id)
            
            // Update payment options based on property details
            if let paymentOption = viewModel.property?.property?.paymentMethods {
                self.paymentOption = Array(paymentOption)
            }
            
            // Update visibility and display status based on API response
            isViewVisible = viewModel.properties?.error == nil
            showAlert = viewModel.properties?.error != nil || viewModel.property?.property == nil
            errorMessage = viewModel.property?.error?.localizedDescription ?? ""
            notAvailableMessage = """
                                     Oops!!
                                     Property details is Not available !
                                     """
        }
    }
}

//#Preview {
//    PropertyDetailScreen(id: "")
//}

