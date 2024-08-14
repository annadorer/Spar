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
    @Published var addedToCartItems: [Item] = []
    @Published var selectedItemAmount: [ItemCart] = [] //TODO Переименовать
    
    init(fetchDataService: FetchDataService) {
        self.fetchDataService = fetchDataService
        Task {
            try? await fetchData()
        }
    }
    
    private func fetchData() async throws {
        let fetchedData = await fetchDataService.fetch() as? [Item]
        await MainActor.run {
            addedToCartItems = fetchedData ?? []
        }
    }
    
    func fetchMore(index: Int) {
        Task {
            if index + 4 >= addedToCartItems.count {
                let fetchedData = await fetchDataService.fetch() as? [Item]
                if fetchedData != nil {
                    await MainActor.run {
                        addedToCartItems.append(contentsOf: fetchedData!)
                    }
                }
            }
        }
    }
    
    func addOrUpdateItemToCart(item: ItemCart) {
        let existItemCartIndex = selectedItemAmount.firstIndex(where: { itemCart in
            itemCart.id == item.id
        })
        if existItemCartIndex != nil {
            selectedItemAmount.remove(at: existItemCartIndex!)
        }
        selectedItemAmount.append(item)
    }
    
    func deleteItemInCart(itemId: UUID) {
        let existItemCartIndex = selectedItemAmount.firstIndex(where: { itemCart in
            itemCart.id == itemId
        })
        if existItemCartIndex != nil {
            selectedItemAmount.remove(at: existItemCartIndex!)
        }
    }
}
