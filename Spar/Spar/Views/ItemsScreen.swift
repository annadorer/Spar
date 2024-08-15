//
//  ItemsView.swift
//  Spar
//
//  Created by Anna on 10.08.2024.
//

import SwiftUI
import UISystem
import Swinject

struct ItemsScreen<ViewModel: ItemsScreenViewModelProtocol>: View {
    
    @State private var isGrid = true
    @StateObject private var viewModel: ViewModel
    
    private let twoColumnGrid = Array(repeating: GridItem(.flexible(minimum: 168, maximum: 176)), count: 2)
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if isGrid {
                    grid
                } else {
                    list
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
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartScreen(items: viewModel.cartItems)) {
                        Text(UI.Strings.cart)
                            .font(.cartText())
                            .foregroundColor(Color.designColor.button)
                            .frame(width: 80, height: 40)
                            .background(Color.designColor.buttonNavigationBlackground)
                            .cornerRadius(12)
                        
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.designColor.appBackground, for: .navigationBar)
        }
        .tint(Color.designColor.button)
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var grid: some View {
        LazyVGrid(columns: twoColumnGrid, spacing: 10) {
            ForEach(Array(viewModel.items.enumerated()), id: \.offset) { index, item in
                GridCardView(item: item,
                             onItemCartAdd: viewModel.addOrUpdateItemToCart,
                             onItemCartDelete: viewModel.deleteItemInCart,
                             selectedUnit: viewModel.cartItems.first(where: { $0.id == item.id })?.selectedAmount)
                .onAppear {
                    viewModel.fetchMore(index: index)
                }
            }
        }
    }
    
    private var list: some View {
        LazyVStack() {
            ForEach(Array(viewModel.items.enumerated()), id: \.offset) { index, item in
                ListCardView(item: item,
                             selectedUnit: viewModel.cartItems.first(where: { $0.id == item.id })?.selectedAmount,
                             onItemCartAdd: viewModel.addOrUpdateItemToCart,
                             onItemCartDelete: viewModel.deleteItemInCart)
                .onAppear {
                    viewModel.fetchMore(index: index)
                }
                Divider()
                    .frame(height: 1)
                    .foregroundColor(Color.designColor.divider)
            }
        }
    }
}

struct ItemsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ItemsScreen(viewModel: ItemsScreenViewModel(fetchDataService: Container.fetchDataService))
    }
}
