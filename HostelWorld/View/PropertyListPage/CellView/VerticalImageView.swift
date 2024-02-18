//
//  SwiftUIView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct VerticalImageView: View {
    let images: [PropertyImage]
    @State private var currentPage: Int = 0
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(images.indices, id: \.self) { index in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        // Checked if the realm obj is not deleted before accessing it
                        if !images.contains(where: {$0.isInvalidated}) {
                            LoadImages(width: UIScreen.main.bounds.width - 70, height: 100,urlString: images[index].prefix+images[index].suffix)
                        }
                        
                        
                    }
                    
                }.tag(index)
                
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Reset the current page when the app enters the foreground
            self.currentPage = 0
            
        }
    }
}

//#Preview {
//    VerticalImageView(images: [PropertyImage]())
//}

