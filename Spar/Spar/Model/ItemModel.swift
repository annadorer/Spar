//
//  ItemModel.swift
//  Spar
//
//  Created by Anna on 08.08.2024.
//

import Foundation
import SwiftUI

struct Item {
    var id = UUID()
    var name: String
    var image: String
    var price: Double
    var discount: Double?
    var units: any Collection<ItemUnit>
    var ratingNumber: String
    var review: Int?
    var tag: Tag?
    var country: Country?
    var priceWithDiscount: Double {
        if discount != nil {
            return price * discount!
        } else {
            return price
        }
    }
    
    func reviewString(for number: Int) -> String {
        let cases = [2, 3, 4]
        if number % 10 == 1 && number % 100 != 11 {
            return "\(number) отзыв"
        } else if cases.contains(number % 10) && !(number % 100 >= 12 && number % 100 <= 14) {
            return "\(number) отзыва" //TODO тоже самое
        } else {
            return "\(number) отзывов" //TODO локалайзед
        }
    }

}

struct ItemUnit: Hashable {    
    var unit: String
    var priceCoefficient: Double
    var addingCoefficient: Double
}

struct Tag {
    var color: Color
    var text: String
}

struct Country {
    var countryName: String
    var flag: String
}
