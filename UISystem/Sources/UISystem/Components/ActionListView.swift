//
//  ActionListView.swift
//  Spar
//
//  Created by Anna on 09.08.2024.
//

import SwiftUI

public struct ActionListView: View {
    
    @State private var isLiked = false
    
    public init() {}
    
    public var body: some View {
        VStack {
            Button(action: {}) {
                Image.designIcon.orderList
            }
            .padding(.all, 4)
            
            Button(action: {
                isLiked.toggle()
            }) {
                isLiked ? Image.designIcon.activeFavorites : Image.designIcon.favorites
            }
            .padding(.all, 4)
            
        }
        .frame(width: 32, height: 64)
        .background(Color.designColor.actionList)
        .cornerRadius(16)
        
    }
}

public struct ActionListView_Previews: PreviewProvider {
    public static var previews: some View {
        ActionListView()
    }
}
