//
//  ItemCartModel.swift
//  Spar
//
//  Created by Anna on 13.08.2024.
//

import Foundation

struct ItemCart {
    var id: UUID
    var name: String
    var priceWithDiscount: Double
    var image: String
    var selectedAmount: SelectedAmount
}

struct SelectedAmount {
    var selectedAmount: Double //TODO Переименовать в селектед каунт
    var selectedUnit: ItemUnit
}
