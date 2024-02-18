//
//  AddressView.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 17/02/2024.
//

import SwiftUI

/*
   The `AddressView` struct is a SwiftUI view responsible for displaying an address along with a location icon.

   - Properties:
     - address: String: The address to be displayed.
   
   - Body:
     - Utilizes HStack to horizontally arrange an image of a location icon and the address text.
     - The location icon is an "mappin.and.ellipse" system image, resized and colored accordingly.
     - The address text is displayed with a specific font, alignment, and minimum scale factor.
     - Adjusts padding for proper layout.
*/

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
