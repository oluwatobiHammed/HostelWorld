//
//  PropertyImage.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct LoadPropertyImage: View {
    
    let images: [PropertyImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(images.indices, id: \.self) { index in
                    
                    LoadImages(width: UIScreen.main.bounds.width - 70, height: 100, urlString: images[index].prefix+images[index].suffix)
                    
                }
                
            }
            
        }
    }
}

//#Preview {
//    LoadPropertyImage(images: [PropertyImage]())
//}
