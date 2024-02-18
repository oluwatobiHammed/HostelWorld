//
//  PropertyDetailsDescriptionView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 18/02/2024.
//

import SwiftUI

struct PropertyDetailsDescriptionView: View {
    let description: String
    let isLoading: Bool
    var body: some View {
        TitleAndSubTitleReuseableView(title: "Description")
        DescriptionView(propertyDescription: description, isLoading: isLoading)
        
        Divider()
            .frame(height: 0.3)
            .background(Color.primary)
            .padding(.leading, 15)
            .padding(.trailing, 25)
            .padding(.top, 10)
            .padding(.bottom, 20)
    }
}

#Preview {
    PropertyDetailsDescriptionView(description: "", isLoading: false)
}
