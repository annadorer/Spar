//
//  SwiftUIView.swift
//  Spar
//
//  Created by Anna on 13.08.2024.
//

import SwiftUI
import UISystem

struct CartScreen: View {
    
    @State private var items: [ItemCart]
    
    private var totalSum: Double {
        items.reduce(0) { $0 + $1.priceWithDiscount * $1.selectedAmount.unit.priceCoefficient}
    }
    
    init(items: [ItemCart]) {
        _items = State(initialValue: items)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach($items, id: \.id) { $item in
                    HStack {
                        Text($item.wrappedValue.name)
                            .font(.title3)
                            .foregroundColor(Color.designColor.itemName)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        Spacer()
                        VStack(alignment: .center, spacing: 5) {
                            Text(String(format: "%.1f", item.selectedAmount.unit.priceCoefficient == 1.0 ? "%.1f %@" : "%.0f %@", $item.wrappedValue.selectedAmount.count,  $item.wrappedValue.selectedAmount.unit.rawValue).appending(item.selectedAmount.unit.rawValue))
                                .font(.priceCents())
                            Text(String(format: "%.1f", item.priceWithDiscount * $item.wrappedValue.selectedAmount.unit.priceCoefficient).appending(UI.Strings.currency))
                                .font(.priceBig())
                        }
                    }
                }
            }
            .background(Color.designColor.appBackground)
            .listStyle(.plain)
            
            HStack {
                Text(UI.Strings.total)
                    .font(.priceBig())
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 10)
                Spacer()
                Text(String(format: "%.1f", totalSum).appending(UI.Strings.currency))
                    .font(.priceBig())
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 10)
            }
            .frame(width: 268, height: 56)
            .background(Color.red)
            .cornerRadius(30)
        }
    }
}

struct CartScreen_Previews: PreviewProvider {
    static var previews: some View {
        CartScreen(items: [
            .init(id: UUID(),
                  name: "Салат овощной с крабовыми палочками",
                  priceWithDiscount: 1.0,
                  image: "FirstItemImage",
                  selectedAmount: .init(count: 1.5, unit: .kg))
        ])
    }
}
