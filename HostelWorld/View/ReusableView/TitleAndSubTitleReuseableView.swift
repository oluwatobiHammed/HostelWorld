//
//  TitleView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

/*
   The `TitleAndSubTitleReuseableView` struct is a SwiftUI view designed to display a title with customizable font size, minimum scale factor, line limit, and top padding.

   - Properties:
     - title: String: The title text to be displayed.
     - fontSize: Font?: The font size of the title text, with a default value of EffraHeavyRegular 20.
     - minimumScaleFactor: CGFloat: The minimum scale factor for the title text when scaling down.
     - lineLimit: Int?: The maximum number of lines for the title text. If nil, there is no limit.
     - topPadding: CGFloat: The top padding to adjust the vertical position of the view.

   - Body:
     - Utilizes HStack to horizontally arrange the title text with proper styling.
       - Applies the specified font size, minimum scale factor, line limit, and top padding.
*/


struct TitleAndSubTitleReuseableView: View {
    let title: String
    let fontSize: Font?
    let minimumScaleFactor: CGFloat
    let lineLimit: Int?
    let topPadding: CGFloat
    
    init(title: String, fontSize: Font = Font(kFont.EffraHeavyRegular.of(size: 20)), minimumScaleFactor: CGFloat = 0.3, lineLimit: Int? = nil, topPadding: CGFloat = -15) {
        self.title = title
        self.fontSize = fontSize
        self.minimumScaleFactor = minimumScaleFactor
        self.lineLimit = lineLimit
        self.topPadding = topPadding
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(fontSize)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(minimumScaleFactor)
                .lineLimit(lineLimit)
                .padding()
            Spacer()
        }
        .padding(.top, topPadding)
    }
}

#Preview {
    TitleAndSubTitleReuseableView(title: "sample")
}
