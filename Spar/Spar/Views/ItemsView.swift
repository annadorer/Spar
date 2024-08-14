//
//  ItemsView.swift
//  Spar
//
//  Created by Anna on 10.08.2024.
//

import SwiftUI
import UISystem

struct ItemsScreen: View {
    
    @State private var isGrid = true
    
    private var twoColumnGrid = Array(repeating: GridItem(.flexible(minimum: 168, maximum: 176), spacing: 0), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if isGrid {
                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                        ForEach((0...20), id: \.self) { item in
                            GridCardView()
                        }
                    }
                } else {
                    LazyVStack() {
                        ForEach((0...20), id: \.self) { item in
                            ListCardView()
                            Divider()
                                .frame(height: 1)
                                .foregroundColor(Color.designColor.divider)
                        }
                    }
                }
            }
            .padding(.top, 10)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isGrid.toggle()
                    }) {
                        Group {
                            if isGrid {
                                Image.designIcon.grid
                            } else {
                                Image.designIcon.list
                            }
                        }
                        .padding(.trailing, -8)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.designColor.buttonNavigationBlackground)
                    .cornerRadius(12)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.designColor.appBackground, for: .navigationBar)
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
