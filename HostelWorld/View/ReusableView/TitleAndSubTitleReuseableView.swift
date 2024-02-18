//
//  TitleView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

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
