//
//  View+PartialRoundedCorners.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 18/02/2024.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
          clipShape(RoundedCorner(radius: radius, corners: corners))
      }
}
