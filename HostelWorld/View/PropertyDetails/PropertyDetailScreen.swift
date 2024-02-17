//
//  PropertyScreen.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct PropertyDetailScreen: View {
    let id: String
    @ObservedObject private var viewModel =  PropertiesViewModel()
    @State private var images: [PropertyImage] = []
    @State private var paymentOption: [String] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 0)
                
                LoadPropertyDetailsImage(images: images)
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
        .scrollIndicators(.hidden)
        .onLoad {
            getProperty()
        }
        
        .navigationTitle(viewModel.property?.property?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: MyBackButton(label: viewModel.property?.property?.city?.country ?? ""))
    }
    
    private func getProperty() {
        Task {
            viewModel.property = await viewModel.getProperty(id: id)
            if let propertyimages = viewModel.property?.property?.images {
                images = Array(propertyimages)
            }
            
            if let paymentOption = viewModel.property?.property?.paymentMethods {
                self.paymentOption = Array(paymentOption)
            }
        }
    }
}

//#Preview {
//    PropertyDetailScreen(id: "")
//}
