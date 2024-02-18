//
//  ContentView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var stackPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $stackPath) {
            // Your main content goes here
            HomePageTableView()
            
        }
    }
    
}

//#Preview {
//    ContentView()
//}

