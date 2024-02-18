//
//  SwiftUIView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

/*
   The `VerticalImageView` struct is a SwiftUI view designed to display a set of vertical images within a TabView.

   - Properties:
     - images: [PropertyImage]: An array of PropertyImage objects representing the images to be displayed.
     - currentPage: @State Int: A state variable to keep track of the currently selected page in the TabView.
   
   - Body:
     - Utilizes TabView to create a swipeable container for a set of ScrollView items.
       - Each ScrollView contains a LazyHStack with LoadImages to display the images horizontally.
       - The LazyHStack ensures efficient loading and rendering of images.
     - Implements PageTabViewStyle for visual presentation and navigation of pages.
     - Resets the currentPage when the app enters the foreground to ensure proper navigation behavior.
*/

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

