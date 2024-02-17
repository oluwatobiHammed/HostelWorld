//
//  IndexPage.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct IndexPage: View {
    var body: some View {
        Image(.logo)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .foregroundColor(Color.primary)
            .padding()
            .padding(.trailing, 0)
    }
}

#Preview {
    IndexPage()
}
