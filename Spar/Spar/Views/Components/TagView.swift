//
//  TagView.swift
//  Spar
//
//  Created by Anna on 09.08.2024.
//

import SwiftUI
import UISystem

struct TagView: View {
    
    var tag: Tag
    
    var body: some View {
        Text(tag.text)
            .frame(width: 84, height: 16)
            .padding(.leading, 8)
            .font(.tagText()).foregroundColor(Color.designColor.tagText)
            .background(tag.color)
            .cornerRadius(20, corners: [.topLeft, .bottomRight, .topRight])
    }
}

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
} //TODO Также вынести

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
} //TODO Вынести в отдельный файл с расширениями

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: .init(color: Color.designColor.saleTag, text: "Удар по ценам"))
    }
}
