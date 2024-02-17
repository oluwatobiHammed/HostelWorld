//
//  HostelWorldApp.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 15/02/2024.
//

import SwiftUI

@main
struct HostelWorldApp: App {
    @State private var showContentView = false
    var body: some Scene {
        WindowGroup {
           
            if showContentView {
                ContentView()
            } else {
                IndexPage()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor(hexString: "#f26839")))
                    .onLoad {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            showContentView = true
                        })
                    }
            }
            
        }
    }
    
    func load() {
       
    }
}
