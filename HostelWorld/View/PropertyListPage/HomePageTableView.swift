//
//  HomePageTableView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

/*
   The `HomePageTableView` struct is a SwiftUI view representing the main content view for displaying a list of city properties.

   - Properties:
     - viewModel: PropertiesViewModel: Manages the data and business logic related to properties.
     - isRefreshing: Bool: Indicates whether the view is currently being refreshed.
     - showAlert: Bool: Controls the visibility of an alert for error messages.
     - showErrorMessage: Bool: Indicates whether to display an error message.
     - errorMessage: String: The message to be shown in case of an error.
   
   - Body:
     - Utilizes a ZStack to layer various components:
       - PropertyListScrollView for displaying a scrollable list of city properties.
       - NavigationDestination for handling navigation to the PropertyDetailScreen when a property is selected.
       - Redacted state for showing a placeholder UI during loading.
       - Alert for presenting error messages with retry and OK options.
       - Pull-to-refresh functionality for reloading the property list.
       - IndexPage view for an empty property list.
       - Additional text and styling for cases where there are no properties available.
     - Triggers the `loadPropertyList` function on load to fetch property data.
     - Provides a reload button in the navigation bar for manually refreshing the property list.
*/

struct HomePageTableView: View {
    
    @StateObject private var viewModel =  PropertiesViewModel()
    @State private var isRefreshing: Bool = false
    @State private var showAlert: Bool = false
    @State private var showErrorMessage: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        ZStack {
            
            PropertyListScrollView(isLoading: viewModel.isLoading, properties: viewModel.properties?.properties ?? [])
                    .scrollIndicators(.hidden)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(for: CityProperty.self) { property in
                        PropertyDetailScreen(id: property.id)
                    }
                    .redacted(reason: viewModel.isLoading ? .placeholder : [])
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
           
                
            if (viewModel.properties?.properties.isEmpty ?? true) {
                IndexPage()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor(hexString: "#f26839")))
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

//#Preview {
//    HomePageTableView()
//}
