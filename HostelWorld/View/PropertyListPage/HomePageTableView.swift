//
//  HomePageTableView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct HomePageTableView: View {
    
    @StateObject private var viewModel =  PropertiesViewModel()
    @State private var isRefreshing: Bool = false
    @State private var showAlert: Bool = false
    @State private var showErrorMessage: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        ZStack {
            PropertyListScrollView(properties: viewModel.properties?.properties ?? [])
                .scrollIndicators(.hidden)
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: CityProperty.self) { property in
                    PropertyDetailScreen(id: property.id)
                }
                .alert("Something happened", isPresented: $showAlert) {
                    Button("Retry") {
                        // Handle OK button action
                        showAlert = false
                        viewModel.memoryCleanUp()
                        loadPropertyList()
                    }
                    
                    Button("ok") {
                        // Handle OK button action
                        showAlert = false
                        
                    }
                }
                   message: {
                    Text(errorMessage)
                  }

                .navigationBarItems(trailing:
                              Button(action: {
                                  // Reload the data
                                  self.reload()
                              }) {
                                  Image(systemName: "arrow.clockwise.circle")
                                      .imageScale(.large)
                              }
                          )
                          .pullToRefresh(isRefreshing: $isRefreshing) {
                              self.reload()
                          }
                .padding()
                .padding(.top, -15)
            .onLoad {
                viewModel.memoryCleanUp()
                loadPropertyList()
                
            }
            
            if (viewModel.properties?.properties.isEmpty ?? false), errorMessage.isEmpty {
                Spacer()
                HStack {
                    let errorMessage = """
                                     Oops!!
                                     No available property!
                                     Be sure to check back soon.
                                     """
                    Text(errorMessage)
                        .multilineTextAlignment(.center) // You can adjust the alignment as needed
                                    .padding()
                }
                Spacer()
            }
        }

    }
    
    private func loadPropertyList() {
        Task {
             await viewModel.getProperties()
            showAlert = viewModel.properties?.error != nil
            errorMessage = viewModel.properties?.error?.localizedDescription ?? ""
        }
    }
    
    func reload() {
        
        viewModel.memoryCleanUp()
        loadPropertyList()
        // Set isRefreshing to false after data is reloaded
        self.isRefreshing = false
    }
}

#Preview {
    HomePageTableView()
}
