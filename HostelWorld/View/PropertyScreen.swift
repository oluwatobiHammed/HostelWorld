//
//  PropertyScreen.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct PropertyScreen: View {
    let id: String
    @ObservedObject private var viewModel =  PropertiesViewModel()
    @State private var images: [PropertyImage] = []
    @State private var paymentOption: [String] = []
    @State private var isExpanded = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 0)
                
                LoadPropertyImage(images: images)
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                HStack {
                    Text(viewModel.property?.property?.type ?? "")
                        .font(Font(kFont.EffraRegular.of(size: 11)))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .padding()
                    Spacer()
                }
                .padding(.top, 0)
                HStack {
                    HStack {
                        Text(viewModel.property?.property?.name ?? "")
                            .font(Font(kFont.EffraHeavyRegular.of(size: 20)))
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.3)
                            .lineLimit(2)
                            .padding()
                        Spacer()
                    }
                    .padding(.leading, 0)
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.yellow)
                            .padding()
                            .padding(.trailing, -5)
                        let stringFormat = String(format: "%.1f",  Double(viewModel.property?.property?.rating?.overall.value ?? 0) / 10)
                        Text(stringFormat)
                            .font(Font(kFont.EffraMediumRegular.of(size: 18)))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .padding(.leading, -10)
                    }
                    .padding(.trailing, 10)
                    
                    
                }
                .padding(.top, -25)
                
                HStack {
                    Text("Directions")
                        .font(Font(kFont.EffraHeavyRegular.of(size: 20)))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .padding()
                    Spacer()
                }
                .padding(.top, -15)
                
                HStack {
                    Text(viewModel.property?.property?.directions ?? "")
                        .font(Font(kFont.EffraRegular.of(size: 14)))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(nil) // Allow the Text to have unlimited lines
                        .padding()
                    Spacer()
                }
                .padding(.top, -19)
                
                HStack {
                    Text("Description")
                        .font(Font(kFont.EffraHeavyRegular.of(size: 20)))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .padding()
                    Spacer()
                }
                .padding(.top, -15)
                HStack {
                    
                    HStack {
                        // Content that can be collapsed or expanded
                        if isExpanded {
                            Text(viewModel.property?.property?.propertyDescription ?? "")
                                .font(Font(kFont.EffraRegular.of(size: 14)))
                                .multilineTextAlignment(.leading)
                                .padding()
                                .minimumScaleFactor(0.3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(nil) // Allow the Text to have unlimited lines
                        } else {
                            Text(viewModel.property?.property?.propertyDescription ?? "")
                                .font(Font(kFont.EffraRegular.of(size: 14)))
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(3) // Limit the Text to 2 lines initially
                        }
                        
                        Spacer()
                        
                        
                    }
                    
                    Spacer()
                }
                .padding(.top, -25)
                HStack {
                    Spacer()
                    // Button to toggle the state
                    Button(action: {
                        withAnimation {
                            self.isExpanded.toggle()
                        }
                    }) {
                       
                        Text(self.isExpanded ? "Collapse" : "Read more")
                            .padding(.all, 0)
                            .padding(.trailing, -3)
                        Image(systemName: "chevron.forward")
                            .padding(.trailing, 12)
                           
                    }
                    
                }
                .padding(.top, -14)
                HStack {
                    Text("Location")
                        .font(Font(kFont.EffraHeavyRegular.of(size: 20)))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .padding()
                    Spacer()
                }
                .padding(.top, 0)
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color.primary)
                        .padding()
                        .padding(.trailing, 0)
                    Text("\(viewModel.property?.property?.address1 ?? ""), \(viewModel.property?.property?.city?.name ?? ""),  \(viewModel.property?.property?.city?.country ?? "") ")
                        .font(Font(kFont.EffraRegular.of(size: 14)))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.3)
                        .lineLimit(nil)
                        .padding()
                        .padding(.leading, -30)
                    Spacer()
                }
                .padding(.top, -25)
                
                HStack {
                    Text("Payment Method")
                        .font(Font(kFont.EffraRegular.of(size: 13)))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.3)
                        .lineLimit(1)
                        .padding()
                    Spacer()
                }
                .padding(.top, 0)
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

#Preview {
    PropertyScreen(id: "")
}

