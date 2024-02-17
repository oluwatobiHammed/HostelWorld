//
//  AddressView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

struct AddressView: View {
    let address: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 16, height: 16)
                .foregroundColor(Color.primary)
                .padding()
                .padding(.trailing, 0)
            Text(address)
                .font(Font(kFont.EffraRegular.of(size: 14)))
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.3)
                .lineLimit(nil)
                .padding()
                .padding(.leading, -30)
            Spacer()
        }
        .padding(.top, -25)
    }
}

#Preview {
    AddressView(address: "")
}
