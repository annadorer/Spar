//
//  MockFetchDataService.swift
//  Spar
//
//  Created by Anna on 12.08.2024.
//

import Foundation
import Combine
import SwiftUI
import UISystem

final class MockFetchDataService: FetchDataService {
    func fetch() async -> any Collection<Item> {
        let randomDelay = Double(arc4random_uniform(3) + 1)
        try! await Task.sleep(nanoseconds: UInt64(randomDelay))
        return [
            .init(name: "сыр Ламбер 500/0 230г", image: "FirstItemImage", price: 199.0, discount: 0.502, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.1", review: 2, tag: .init(color: Color.designColor.saleTag, text: "Удар по ценам")),
            
                .init(name: "Энергетический Напит", image: "SecondItemImage", price: 199.0, discount: 0.205, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Л", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.1", review: 20),
            
                .init(name: "Салат Овощной с Крабовами Палочками", image: "ThirdItemImage", price: 250.0, discount: 0.1, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.5", review: 1),
            
                .init(name: "Дорадо Охлажденная Непотрошенная 300-400г", image: "FourthItemImage", price: 350.0, discount: 0.25, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.9", review: 13),
            
                .init(name: "Ролл Маленькая Япония 216г", image: "FifthImageItem", price: 560.0, discount: 0.1, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "3.8", review: 19, tag: .init(color: Color.designColor.newTag, text: "Новинка")),
            
                .init(name: "Огурцы тепличные садово-огородные", image: "SixthItemImage", price: 258.0, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.1", review: 1, tag: .init(color: Color.designColor.cardPriceTag, text: "Цена по карте"), country:
                    .init(countryName: "Россия", flag: " 🇷🇺")),
            
                .init(name: "Манго Кео", image: "SeventhItemImage", price: 1298.0, discount: 0.45, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "5.0", review: 2, tag: .init(color: Color.designColor.newTag, text: "Новинка")),
            
                .init(name: "Макаронные Изделия SPAR Спаггети 450г", image: "EighthItemImage", price: 350.0, discount: 0.25, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "2.4", review: 17),
            
                .init(name: "Огурцы тепличные садово-огородные", image: "NinthItemImage", price: 199.0, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "5.0", review: 15, tag: .init(color: Color.designColor.cardPriceTag, text: "Цена по карте"), country: .init(countryName: "Япония", flag: "🇯🇵"))
        ]
    }
}
