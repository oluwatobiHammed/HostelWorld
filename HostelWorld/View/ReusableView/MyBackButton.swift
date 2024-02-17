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
             HStack {
                 Image(systemName: "chevron.backward")
                 Text(label)
                     .padding(.leading, -5)
                 Spacer()
             }
             .foregroundColor(.blue)
         }
         .padding()
         .padding(.leading, -27)
         .padding(.trailing, -30)
    }
}


#Preview {
    MyBackButton(label: "")
}
