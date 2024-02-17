//
//  DescriptionView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct DescriptionView: View {
    
    let propertyDescription: String
    
    @State private var isExpanded = false
    
    var body: some View {
        HStack {
            
            // Content that can be collapsed or expanded
            Text(propertyDescription)
                .font(Font(kFont.EffraRegular.of(size: 14)))
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
               
                Text(self.isExpanded ? "Collapse" : "Read more")
                    .padding(.all, 0)
                    .padding(.trailing, -3)
                Image(systemName: "chevron.forward")
                    .padding(.trailing, 12)
                   
            }
            
        }
        .padding(.top, -14)
    }
}

#Preview {
    DescriptionView(propertyDescription: "")
}
