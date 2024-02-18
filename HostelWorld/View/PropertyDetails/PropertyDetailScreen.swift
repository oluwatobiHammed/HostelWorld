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
    @State private var isViewVisible = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 0)
                    
                    LoadPropertyDetailsImage(images: viewModel.images)
                        .redactShimmer(condition: viewModel.isLoading)
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                    
                    TitleView(title: viewModel.property?.property?.type ?? "", fontSize: Font(kFont.EffraRegular.of(size: 11)))
                        .padding(.top, 10)
                    OverallRatingView(overallRating: viewModel.property?.property?.rating?.overall.value, tile: viewModel.property?.property?.name ?? "")
                    
                    TitleView(title: "Directions")
                    
                    TitleView(title: viewModel.property?.property?.directions ?? "", fontSize: Font(kFont.EffraRegular.of(size: 14)), minimumScaleFactor: 0.3, lineLimit: nil)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, -5)
                    
                    
                    TitleView(title: "Description")
                    DescriptionView(propertyDescription: viewModel.property?.property?.propertyDescription ?? "")
                    
                    TitleView(title: "Location")
                        .padding(.top, 5)
                    AddressView(address: "\(viewModel.property?.property?.address1 ?? ""), \(viewModel.property?.property?.city?.name ?? ""),  \(viewModel.property?.property?.city?.country ?? "") ")
                    
                    
                    TitleView(title: "Payment Method")
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
                    let errorMessage = """
                                     Oops!!
                                     Property details is Not available !
                                     """
                    Text(errorMessage)
                        .multilineTextAlignment(.center) // You can adjust the alignment as needed
                        .padding()
                }
                Spacer()
            }
        }
        
        
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
        }
    }
}

//#Preview {
//    PropertyDetailScreen(id: "")
//}

