//
//  PropertyListScrollView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

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
