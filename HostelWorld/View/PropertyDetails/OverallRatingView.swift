//
//  OverallRatingView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct OverallRatingView: View {
    let overallRating: Int?
    let tile: String
    
    var body: some View {
        HStack {
            
            TitleView(title: tile, fontSize: Font(kFont.EffraHeavyRegular.of(size: 20)), minimumScaleFactor: 2)
            .padding(.top, 20)
            .padding(.leading, 0)
            Spacer()
            HStack {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundStyle(.yellow)
                    .padding()
                    .padding(.trailing, -5)
                let stringFormat = String(format: "%.1f",  Double(overallRating ?? 0) / 10)
                Text(stringFormat)
                    .font(Font(kFont.EffraMediumRegular.of(size: 18)))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .padding(.leading, -10)
            }
            .padding(.trailing, 10)
            
            
        }
        .padding(.top, -25)
    }
}

#Preview {
    OverallRatingView(overallRating: 20, tile: "")
}
