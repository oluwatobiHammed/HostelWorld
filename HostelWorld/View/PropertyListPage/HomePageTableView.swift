//
//  HomePageTableView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct HomePageTableView: View {
    
    @ObservedObject private var viewModel =  PropertiesViewModel()
    @State private var isRefreshing: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        PropertyListScrollView(properties: viewModel.properties?.properties ?? [])
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: CityProperty.self) { property in
                PropertyDetailScreen(id: property.id)
            }
            .alert("Retry", isPresented: $showAlert) {
                Button(action: {
                    withAnimation {
                        viewModel.memoryCleanUp()
                        loadPropertyList()
                    }
                }) {
                   
                       
                }
            } message: {
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
        if (viewModel.properties?.properties.isEmpty ?? false), !showAlert {
            let errorMessage = """
                             Oops
                             No available property!
                             Be sure to check back soon.
                             """
            Text(errorMessage)
        }
    }
    
    private func loadPropertyList() {
        Task {
            viewModel.properties = await viewModel.getProperties()
            viewModel.isLoading = !(viewModel.properties?.properties.isEmpty ?? false)
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

//#Preview {
//    HomePageTableView()
//}
