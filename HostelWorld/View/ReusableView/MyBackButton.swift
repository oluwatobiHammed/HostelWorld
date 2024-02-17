//
//  MyBackButton.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct MyBackButton: View {
    var label: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 3) {
                Image(systemName: "chevron.backward")
                Text(label)
                Spacer()
            }
            .foregroundColor(.blue)
        }.padding(.horizontal, -10) // Adjust as needed
        
    }
}


#Preview {
    MyBackButton(label: "")
}
