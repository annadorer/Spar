//
//  View+Extension.swift
//  Spar
//
//  Created by Anna on 14.08.2024.
//

import SwiftUI
import Foundation

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
