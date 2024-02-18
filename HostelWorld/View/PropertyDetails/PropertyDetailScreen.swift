//
//  PropertyScreen.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct PropertyDetailScreen: View {
    let id: String
    @StateObject private var viewModel =  PropertiesViewModel()
    @State private var images: [PropertyImage] = []
    @State private var paymentOption: [String] = []
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var notAvailableMessage: String = ""
    @State private var isViewVisible = false
    
    var body: some View {
        
        ZStack {
            
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
                    
                    TitleAndSubTitleReuseableView(title: "Location")
                        .padding(.top, 5)
                    AddressView(address: "\(viewModel.property?.property?.address1 ?? ""), \(viewModel.property?.property?.city?.name ?? ""),  \(viewModel.property?.property?.city?.country ?? "") ")
                    
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
                    
                    Spacer()
                }
            }
            .opacity(isViewVisible ? 1.0 : 0)
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
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        
    }
    
    private func getProperty() {
        Task {
            await viewModel.getProperty(id: id)
            
            if let paymentOption = viewModel.property?.property?.paymentMethods {
                self.paymentOption = Array(paymentOption)
            }
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

#Preview {
    PropertyDetailScreen(id: "")
}

