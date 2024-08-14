//
//  RoundedCornerView.swift
//  Spar
//
//  Created by Anna on 14.08.2024.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
