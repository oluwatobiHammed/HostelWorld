//
//  ContentView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel =  PropertiesViewModel()
    var body: some View {
        VStack {
             Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            viewModel.properties = await viewModel.getProperties()
        }
    }
}

#Preview {
    ContentView()
}
