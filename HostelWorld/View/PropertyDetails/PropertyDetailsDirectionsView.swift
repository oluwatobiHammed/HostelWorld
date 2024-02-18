//
//  PropertyDetailsDirectionsView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 18/02/2024.
//

import SwiftUI

/*
   The `PropertyDetailsDirectionsView` struct is a SwiftUI view that presents property directions.

   - Properties:
     - direction: String: The directions associated with the property.
   
   - Body:
     - Displays the title "Directions" using a `TitleAndSubTitleReuseableView`.
     - Presents the actual direction content using another `TitleAndSubTitleReuseableView` with specific font size, scaling, and alignment settings.
       - Adjusts frame maxWidth and alignment for better visual appearance.
     - Includes a divider below the direction content for visual separation.
     - Applies appropriate padding for layout adjustments.
*/

struct PropertyDetailsDirectionsView: View {
    let direction: String
    var body: some View {
        TitleAndSubTitleReuseableView(title: "Directions")
        
        TitleAndSubTitleReuseableView(title: direction , fontSize: Font(kFont.EffraRegular.of(size: 16)), minimumScaleFactor: 0.3, lineLimit: nil)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, -5)
        Divider()
            .frame(height: 0.3)
            .background(Color.primary)
            .padding(.leading, 15)
            .padding(.trailing, 25)
            .padding(.top, 5)
            .padding(.bottom, 20)
    }
}

#Preview {
    PropertyDetailsDirectionsView(direction: "")
}
