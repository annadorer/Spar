//
//  ItemCartModel.swift
//  Spar
//
//  Created by Anna on 13.08.2024.
//

import Foundation

struct ItemCart: Identifiable {
    let id: UUID
    let name: String
    let priceWithDiscount: Double
    let image: String
    let selectedAmount: SelectedAmount
}

struct SelectedAmount {
    let count: Double
    let unit: ItemUnit
}
