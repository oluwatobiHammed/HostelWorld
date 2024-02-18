//
//  PropertyDetailsDescriptionView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 18/02/2024.
//

import SwiftUI

/*
   The `PropertyDetailsDescriptionView` struct is a SwiftUI view responsible for displaying the description of a property.

   - Properties:
     - description: String: The property description to be displayed.
     - isLoading: Bool: Indicates whether content is currently loading.
   
   - Body:
     - Utilizes a `TitleAndSubTitleReuseableView` to display the title "Description".
     - Embeds a `DescriptionView` to present the actual property description with appropriate formatting and handling of loading state.
     - Includes a divider below the description content for visual separation.
     - Applies proper padding for layout adjustments.
*/

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
