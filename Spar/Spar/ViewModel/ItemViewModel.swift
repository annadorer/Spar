//
//  ItemViewModel.swift
//  Spar
//
//  Created by Anna on 11.08.2024.
//

import Foundation
import SwiftUI

final class ItemsScreenViewModel: ObservableObject {
    
    private var fetchDataService: FetchDataService
    @Published var items: [Item] = []
    @Published var cartItems: [ItemCart] = []
    
    init(fetchDataService: FetchDataService) {
        self.fetchDataService = fetchDataService
        Task {
            try? await fetchData()
        }
    }
    
    private func fetchData() async throws {
        let fetchedData = await fetchDataService.fetch() as? [Item]
        await MainActor.run {
            items = fetchedData ?? []
        }
    }
    
    func fetchMore(index: Int) {
        Task {
            if index + 4 >= items.count {
                let fetchedData = await fetchDataService.fetch() as? [Item]
                if fetchedData != nil {
                    await MainActor.run {
                        items.append(contentsOf: fetchedData!)
                    }
                }
            }
        }
    }
    
    @MainActor
    func addOrUpdateItemToCart(itemId: UUID, selectedUnit: ItemUnit, selectedCount: Double) {
        let existItem = items.first(where: { item in
            item.id == itemId})
        if existItem == nil {
            return
        }
        let existItemCartIndex = cartItems.firstIndex(where: { itemCart in
            itemCart.id == itemId
        })
        if existItemCartIndex != nil {
            cartItems.remove(at: existItemCartIndex!)
        }
        cartItems.append(.init(id: itemId, name: existItem!.name, priceWithDiscount: existItem!.priceWithDiscount, image: existItem!.image, selectedAmount: .init(selectedCount: selectedCount, selectedUnit: .init(unit: selectedUnit.unit, priceCoefficient: selectedUnit.priceCoefficient, addingCoefficient: selectedUnit.addingCoefficient))))
    }
    
    @MainActor
    func deleteItemInCart(itemId: UUID) {
        let existItemCartIndex = cartItems.firstIndex(where: { itemCart in
            itemCart.id == itemId
        })
        if existItemCartIndex != nil {
            cartItems.remove(at: existItemCartIndex!)
        }
    }
}
