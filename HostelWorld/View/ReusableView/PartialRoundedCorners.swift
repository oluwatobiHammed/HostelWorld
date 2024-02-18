//
//  PartialRoundedCorners.swift
//  HostelWorld
//
//  Created by Oladipupo Oluwatobi on 18/02/2024.
//

import SwiftUI

/*
   The `RoundedCorner` struct is a SwiftUI custom shape that generates a path for a rounded rectangle with specific corners.

   - Properties:
     - radius: CGFloat: The corner radius of the rounded rectangle. Defaults to .infinity.
     - corners: UIRectCorner: The corners to be rounded, represented by a bitmask. Defaults to .allCorners.

   - Method:
     - path(in rect: CGRect) -> Path: Generates and returns a Path based on a UIBezierPath created with the specified rounded rectangle parameters.
*/


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
