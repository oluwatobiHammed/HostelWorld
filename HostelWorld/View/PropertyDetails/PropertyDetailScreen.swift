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
                    
                    if !viewModel.paymentOption.isEmpty {
                        Divider()
                            .frame(height: 0.3)
                            .background(Color.primary)
                            .padding(.leading, 15)
                            .padding(.trailing, 25)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        
                        TitleAndSubTitleReuseableView(title: "Payment Method")
                            .padding(.top, 5)
                        PaymentMethodScrollView(paymentMethod: viewModel.paymentOption)
                            .padding(.top, -15)
                    }
                    
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
            .alert("Something happened", isPresented: $viewModel.showAlert) {
                Button("ok") {
                    // Handle OK button action
                    viewModel.showAlert = false
                    
                }
            }
        message: {
            Text(viewModel.errorMessage)
        }
        .onLoad {
            viewModel.getProperty(id: id)
        }
            
        .navigationTitle(viewModel.property?.property?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
            
            // Display a message if the view is not visible and not loading
            if !viewModel.isViewVisible, !viewModel.isLoading {
                Spacer()
                HStack {
                    Text(viewModel.notAvailableMessage)
                        .multilineTextAlignment(.center) // You can adjust the alignment as needed
                        .padding()
                }
                Spacer()
            }
        }
        // Apply redacted placeholder if data is still loading
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        
    }
    

}

#Preview {
    PropertyDetailScreen(id: "")
}

