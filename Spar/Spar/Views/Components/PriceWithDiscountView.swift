//
//  PriceView.swift
//  Spar
//
//  Created by Anna on 09.08.2024.
//

import SwiftUI
import UISystem

struct PriceWithDiscountView: View {
    
    private let item: Item
    private let fractionalPart: Double
    private let wholePart: Double
    
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
                    
                    if let unit = item.units.first(where: { $0.priceCoefficient == 1 }) {
                        Text(unit.rawValue.lowercased())
                            .font(.priceText())
                            .offset(x: 7, y: 8)
                    }
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
        PriceWithDiscountView(item: .init(name: "сыр Ламбер 500/0 230г",
                                          image: "Image",
                                          price: 199.0,
                                          discount: 0.502,
                                          units: [.kg],
                                          ratingNumber: "4.1"))
    }
}
