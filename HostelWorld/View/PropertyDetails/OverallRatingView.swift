//
//  OverallRatingView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

/*
   The `OverallRatingView` struct is a SwiftUI view designed to display an overall rating for a property.

   - Properties:
     - overallRating: Int?: The numeric rating value (if available).
     - tile: String: A title or label associated with the rating.
   
   - Body:
     - Utilizes HStack to arrange two components:
       - A customized `TitleAndSubTitleReuseableView` displaying the associated title with a specified font size.
       - A sub-HStack displaying a star icon filled with yellow color and the numeric rating.
         - The rating is formatted and displayed with a specified font size, alignment, scaling, and line limit.
     - Adjusts padding for proper layout.
*/

struct OverallRatingView: View {
    let overallRating: Int?
    let tile: String
    
    var body: some View {
        HStack {
            
            TitleAndSubTitleReuseableView(title: tile, fontSize: Font(kFont.EffraHeavyRegular.of(size: 20)), minimumScaleFactor: 2)
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
