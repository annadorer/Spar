//
//  ItemViewModel.swift
//  Spar
//
//  Created by Anna on 11.08.2024.
//

import Foundation
import SwiftUI

protocol ItemsScreenViewModelProtocol: ObservableObject {
    var items: [Item] { get }
    var cartItems: [ItemCart] { get }
    
    func onAppear()
    func fetchMore(index: Int)
    func addOrUpdateItemToCart(itemId: UUID, selectedUnit: ItemUnit, selectedCount: Double)
    func deleteItemInCart(itemId: UUID)
}

final class ItemsScreenViewModel: ItemsScreenViewModelProtocol {
    
    @Published var items: [Item] = []
    @Published var cartItems: [ItemCart] = []
    
    private var fetchDataService: FetchDataServiceProtocol
    
    init(fetchDataService: FetchDataServiceProtocol) {
        self.fetchDataService = fetchDataService
    }
    
    @MainActor
    func onAppear() {
        Task {
            try await fetchData()
        }
    }
    
    @MainActor
    func fetchMore(index: Int) {
        Task {
            let fetchedData = await fetchDataService.fetch()
            await MainActor.run {
                items.append(contentsOf: fetchedData)
            }
            
        }
    }
    
    @MainActor
    func addOrUpdateItemToCart(itemId: UUID, selectedUnit: ItemUnit, selectedCount: Double) {
        guard let existItem = items.first(where: { $0.id == itemId }) else { return }

        cartItems.removeAll(where: { $0.id == itemId })

        cartItems.append(
            .init(id: itemId,
                  name: existItem.name,
                  priceWithDiscount: existItem.priceWithDiscount,
                  image: existItem.image,
                  selectedAmount: .init(count: selectedCount, unit: selectedUnit))
        )
    }
    
    @MainActor
    func deleteItemInCart(itemId: UUID) {
        guard let existItemCartIndex = cartItems.firstIndex(where: { $0.id == itemId }) else {
            return
        }
        cartItems.remove(at: existItemCartIndex)
    }
    
    private func fetchData() async throws {
        let fetchedData = await fetchDataService.fetch()
        await MainActor.run {
            items = fetchedData
        }
    }
}

