//
//  PropertyListScrollView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct PropertyListScrollView: View {
    
    @StateObject private var viewModel =  PropertiesViewModel()
    
    let properties: [CityProperty]
    var body: some View {
        ScrollView {
            ForEach(properties, id: \.self) { property in
                NavigationLink(value: property) {
                    LazyVStack {
                        PropertiesCellView(property: property)
                            .redactShimmer(condition: viewModel.isLoading)
                            .clipShape(RoundedRectangle(cornerRadius: 25)) // Apply corner radius using clipShape
                            .frame(height: 350)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 9)
                            .navigationBarTitle(property.city?.country ?? "")
                    }
                    
                }
                .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default navigation color
                .accentColor(nil) // Remove selection style
                
            }
            
        }
 
    }
}

#Preview {
    PropertyListScrollView(properties: [])
}
