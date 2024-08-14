//
//  ShoppingBasketView.swift
//  Spar
//
//  Created by Anna on 13.08.2024.
//

import SwiftUI

struct ShoppingBasketScreen: View {
    
    @State var item: Item
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0...10, id: \.self) { item in
                    HStack {
                        
                    }
                    
                }
            }
        }
    }
}

struct ShoppingBasketView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingBasketScreen(item: .init(name: "сыр Ламбер 500/0 230г", image: "FirstItemImage", price: 199.0, discount: 0.502, units: [.init(unit: "Кг", priceCoefficient: 2.5, addingCoefficient: 2.5)], ratingNumber: "4.1", review: 19, tag: .init(color: Color.designColor.saleTag, text: "Удар по ценам"), country: .init(countryName: "Франция", flag: " 🇫🇷")))
    }
}
