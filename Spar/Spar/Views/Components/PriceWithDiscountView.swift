//
//  PriceView.swift
//  Spar
//
//  Created by Anna on 09.08.2024.
//

import SwiftUI
import UISystem

struct PriceWithDiscountView: View {
    
    private var item: Item
    private var fractionalPart: Double
    private var wholePart: Double
    
    init(item: Item) {
        self.item = item
        self.fractionalPart = item.priceWithDiscount.truncatingRemainder(dividingBy: 1)
        self.wholePart = item.priceWithDiscount - fractionalPart
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(alignment: .center, spacing: 0) {
                
                Text(String(format: "%.0f", wholePart).replacingOccurrences(of: ".", with: " "))
                    .font(.priceBig())
                
                Text(String(format: "%.2f", fractionalPart).replacingOccurrences(of: "0.", with: " "))
                    .font(.priceCents())
                    .offset(x: 0, y: -1)
                
                ZStack(alignment: .center) {
                    
                    Text(UI.Strings.currency)
                        .font(.priceText())
                        .offset(x: -5, y: -6)
                    Text("\u{0338}")
                        .rotationEffect(.degrees(45))
                        .frame(width: 17)
                        .fontWeight(.bold)
                    Text(item.units.first(where: { unit in
                        unit.priceCoefficient == 1
                    })!.unit.lowercased())
                        .font(.priceText())
                        .offset(x: 7, y: 8)
                }
                .offset(x: 5, y: -3)
            }
            
            Text(String(item.price).replacingOccurrences(of: ".", with: ","))
                .foregroundColor(Color.designColor.oldPrice)
                .font(.caption())
                .strikethrough()
        }
        .padding(.horizontal, 4)
    }
}

struct PriceWithDiscountView_Previews: PreviewProvider {
    static var previews: some View {
        PriceWithDiscountView(item: Item(name: "сыр Ламбер 500/0 230г", image: "Image", price: 199.0, discount: 0.502, units: [.init(unit: "Кг", priceCoefficient: 1.0, addingCoefficient: 2.5)], ratingNumber: "4.1"))
    }
}
