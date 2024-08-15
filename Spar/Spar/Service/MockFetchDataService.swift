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

final class MockFetchDataService: FetchDataServiceProtocol {
    func fetch() async -> [Item] {
        let randomDelay = Double(arc4random_uniform(3) + 1)
        try? await Task.sleep(nanoseconds: UInt64(randomDelay))
        return [
            .init(name: "сыр Ламбер 500/0 230г",
                  image: "FirstItemImage",
                  price: 199.0,
                  discount: 0.502,
                  units: [.pcs, .kg],
                  ratingNumber: "4.1",
                  review: 2,
                  tag: .sale
                 ),
                .init(name: "Энергетический Напит",
                      image: "SecondItemImage",
                      price: 199.0,
                      discount: 0.205,
                      units: [.pcs, .liter],
                      ratingNumber: "4.1",
                      review: 20
                ),
                .init(name: "Салат Овощной с Крабовами Палочками",
                      image: "ThirdItemImage",
                      price: 250.0,
                      discount: 0.1,
                      units: [.pcs, .kg],
                      ratingNumber: "4.5",
                      review: 1
                ),
                .init(name: "Дорадо Охлажденная Непотрошенная 300-400г",
                      image: "FourthItemImage",
                      price: 350.0,
                      discount: 0.25,
                      units: [.pcs, .kg],
                      ratingNumber: "4.9",
                      review: 13
                ),
                .init(name: "Ролл Маленькая Япония 216г",
                      image: "FifthImageItem",
                      price: 560.0,
                      discount: 0.1,
                      units: [.pcs, .kg],
                      ratingNumber: "3.8",
                      review: 19,
                      tag: .new
                ),
                .init(name: "Огурцы тепличные садово-огородные",
                      image: "SixthItemImage",
                      price: 258.0,
                      units: [.pcs, .kg],
                      ratingNumber: "4.1",
                      review: 1,
                      tag: .cardPrice,
                      country: .russia
                ),
                .init(name: "Манго Кео",
                      image: "SeventhItemImage",
                      price: 1298.0,
                      discount: 0.45,
                      units: [.pcs, .kg],
                      ratingNumber: "5.0",
                      review: 2,
                      tag: .new
                ),
                .init(name: "Макаронные Изделия SPAR Спаггети 450г",
                      image: "EighthItemImage",
                      price: 350.0,
                      discount: 0.25,
                      units: [.pcs, .kg],
                      ratingNumber: "2.4",
                      review: 17
                ),
                .init(name: "Огурцы тепличные садово-огородные",
                      image: "NinthItemImage",
                      price: 199.0,
                      units: [.pcs, .kg],
                      ratingNumber: "5.0",
                      review: 15,
                      tag: .cardPrice,
                      country: .japan)
        ]
    }
}
