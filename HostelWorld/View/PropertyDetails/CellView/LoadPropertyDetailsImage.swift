//
//  PropertyImage.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct LoadPropertyDetailsImage: View {
    
    let images: [PropertyImage]
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(images.indices, id: \.self) { index in
                    if !images.contains(where: {$0.isInvalidated}) {
                        LoadImages(width: width, height: height, urlString: images[index].prefix+images[index].suffix, isCorner: index == 0)
                            .padding(.leading, index == 0 ? 15 : 0)
                    }
                    
                }
                
            }
            
        }
    }
}

//#Preview {
//    LoadPropertyImage(images: [PropertyImage]())
//}
