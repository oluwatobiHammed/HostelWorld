//
//  LoadImages.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 16/02/2024.
//

import SwiftUI

struct LoadImages: View {
    
    
    let width: CGFloat
    let height: CGFloat
    let urlString: String
    let isCorner: Bool
    init(width: CGFloat, height: CGFloat, urlString: String, isCorner: Bool = false) {
        self.width = width
        self.height = height
        self.urlString = urlString
        self.isCorner = isCorner
    }
    var body: some View {
        
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .cornerRadius(isCorner ? 8 : 0, corners: [.topLeft, .bottomLeft])
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height) // Adjust the frame as needed
                
            case .failure(_):
                // Handle the error, e.g., show a default image
                Image(.photo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .background(Color.clear)
                    .padding()
                
            case .empty:
                // Placeholder view while loading
                Image(.photo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .background(Color.clear)
                    .padding()
            @unknown default:
                fatalError()
            }
        }
        
    }
}

//#Preview {
//    LoadImages()
//}
