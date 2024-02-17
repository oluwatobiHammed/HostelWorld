//
//  ContentView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = PropertiesViewModel()
    
    var body: some View {
        NavigationStack {
            // Your main content goes here
            HomePageTableView()
            
        }
    }
    
}

//#Preview {
//    ContentView()
//}

