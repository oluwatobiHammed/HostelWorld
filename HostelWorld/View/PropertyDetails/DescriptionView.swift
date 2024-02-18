//
//  DescriptionView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI


/*
   The `DescriptionView` struct is a SwiftUI view designed to display property descriptions with an option to expand or collapse the content.

   - Properties:
     - propertyDescription: String: The description to be displayed.
     - isExpanded: Bool: A state variable to determine whether the description is expanded or collapsed.
     - isLoading: Bool: Indicates whether content is currently loading.
   
   - Body:
     - Utilizes two HStacks to structure the view:
       - The first HStack displays the property description with adjustable text alignment, scaling, and line limit.
       - The second HStack contains a button allowing the user to toggle the description state.
         - The button text changes based on the expanded or collapsed state.
         - An arrow icon indicates the direction of the toggle.
     - Appropriate padding is applied for layout adjustments.
*/

struct DescriptionView: View {
    
    let propertyDescription: String
    @State private var isExpanded = false
    let isLoading: Bool
    var body: some View {
        HStack {
            
            // Content that can be collapsed or expanded
            Text(propertyDescription)
                .font(Font(kFont.EffraRegular.of(size: 16)))
                .multilineTextAlignment(.leading)
                .padding()
                .minimumScaleFactor(isExpanded ? 0.3 : 0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(isExpanded ? nil : 3) // Allow the Text to have unlimited lines
            
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
               
                Text(self.isExpanded ? "Done" : "Read more")
                    .padding(.all, 0)
                    .padding(.trailing, -3)
                Image(systemName: "chevron.forward")
                    .padding(.trailing, 12)
                   
            }
            .disabled(isLoading)
            
        }
        .padding(.top, -14)
    }
}

#Preview {
    DescriptionView(propertyDescription: "", isLoading: false)
}
