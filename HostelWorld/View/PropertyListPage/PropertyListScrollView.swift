//
//  PropertyListScrollView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

/*
   The `PropertyListScrollView` struct is a SwiftUI view responsible for displaying a scrollable list of city properties.

   - Properties:
     - viewModel: PropertiesViewModel: Manages the data and business logic related to properties.
     - isLoading: Bool: Indicates whether content is currently loading.
     - properties: [CityProperty]: An array of city properties to be displayed.
   
   - Body:
     - Utilizes a ScrollView with a LazyVStack for efficiently rendering a vertical stack of city properties.
     - Iterates over the array of properties and displays each property using the `PropertiesCellView`.
       - Configures each cell with styling, frame height, and padding for proper layout.
       - Uses NavigationLink for navigation to the PropertyDetailScreen when a property is selected.
       - Applies button styles to remove default navigation colors and disables interaction during loading.
     - Implements redaction for a placeholder UI during loading.
*/

struct PropertyListScrollView: View {
    
    @StateObject private var viewModel =  PropertiesViewModel()
    let isLoading: Bool
    let properties: [CityProperty]
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                
                ForEach(properties, id: \.self) { property in
                    
                    NavigationLink(value: property) {
                        
                        PropertiesCellView(property: property)
                        
                            .clipShape(RoundedRectangle(cornerRadius: 25)) // Apply corner radius using clipShape
                            .frame(height: 350)
                            .padding(.horizontal, 9)
                            .navigationBarTitle(property.city?.country ?? "")
                        
                        
                    }
                    .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default navigation color
                    .disabled(isLoading)
                    .accentColor(nil) // Remove selection style
                }
                .redacted(reason: isLoading ? .placeholder : [])
            }
            
        }
 
    }
}

//#Preview {
//    PropertyListScrollView(properties: [])
//}
