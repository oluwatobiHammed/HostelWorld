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
    var body: some View {
        
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
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
                ProgressView()
            @unknown default:
                fatalError()
            }
        }
        
    }
}

//#Preview {
//    LoadImages()
//}
