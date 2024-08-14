//
//  GridCardView.swift
//  
//
//  Created by Anna on 08.08.2024.
//

import SwiftUI
import UISystem

struct GridCardView: View {
    
    @State private var selectedAmount: Double = 0.0
    @State private var selectedUnit: ItemUnit
    @State private var item: Item
    @State private var onItemCartAdd: (ItemCart) -> Void
    @State private var onItemCartDelete: (UUID) -> Void
    
    init(item: Item, onItemCartAdd: @escaping (ItemCart) -> Void, onItemCartDelete: @escaping (UUID) -> Void) {
        self._item = State(initialValue: item)
        self._onItemCartAdd = State(initialValue: onItemCartAdd)
        self._onItemCartDelete = State(initialValue: onItemCartDelete)
        self._selectedUnit = State(initialValue: item.units.first!)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            top
            bottom
        }
        .frame(width: 168, height: 278)
        .background(Color.designColor.appBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 2)
    }
    
    var top: some View {
        ZStack(alignment: .bottomLeading) {
            Image(item.image)
                .frame(width: 168, height: 168)
            HStack(spacing: 2) {
                Image.designIcon.rating
                Text(item.ratingNumber)
                    .font(.caption())
                Spacer()
                if (item.discount != nil) {
                    Text(String(format: "%.2f", item.discount!).replacingOccurrences(of: "0.", with: "").appending("%"))
                        .foregroundColor(Color.designColor.sale).font(.saleText())
                }
            }
            .padding([.horizontal, .bottom], 5)
        }
        .overlay(
            Group {
                if let tag = item.tag {
                    TagView(tag: tag)
                } else {
                    EmptyView()
                }
            }, alignment: .topLeading
        )
        .overlay(
            ActionListView(),
            alignment: .topTrailing)
    }
    
    var bottom: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.caption()).foregroundColor(Color.designColor.itemName)
                .padding(.horizontal, 8)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            Group {
                if selectedAmount != 0.0 {
                    QuantitySelectorView(selectedAmount: $selectedAmount, selectedUnit: $selectedUnit, itemAmounts: item.units as! [ItemUnit], basePrice: item.priceWithDiscount,
                                         onPlusClick: {
                        onItemCartAdd(.init(id: item.id, name: item.name, priceWithDiscount: item.priceWithDiscount, image: item.image, selectedAmount: .init(selectedAmount: selectedAmount, selectedUnit: selectedUnit)))
                                         },
                                         onMinusClick: {
                                             if (selectedAmount <= 0) {
                                                 onItemCartDelete(item.id)
                                             }else {
                                                 onItemCartAdd(.init(id: item.id, name: item.name, priceWithDiscount: item.priceWithDiscount, image: item.image, selectedAmount: .init(selectedAmount: selectedAmount, selectedUnit: selectedUnit)))
                                             }
                                         }, onUnitChange: {
                                             onItemCartAdd(.init(id: item.id, name: item.name, priceWithDiscount: item.priceWithDiscount, image: item.image, selectedAmount: .init(selectedAmount: selectedAmount, selectedUnit: selectedUnit)))
                                         })
                    .padding(.horizontal, 4)
                    .padding(.bottom, 6)
                } else {
                    HStack(spacing: 2) {
                        PriceWithDiscountView(item: item)
                        Spacer()
                        Button(action: {
                            selectedAmount += selectedUnit.addingCoefficient
                            onItemCartAdd(.init(id: item.id, name: item.name, priceWithDiscount: item.priceWithDiscount, image: item.image, selectedAmount: .init(selectedAmount: selectedAmount, selectedUnit: selectedUnit)))
                        }) {
                            Image.designIcon.shoppingBasket
                        }
                        .buttonStyle(ActionButtonStyle())
                    }
                    .padding([.bottom, .horizontal], 4)
                }
            }
        }
    }
}

struct GridCardView_Previews: PreviewProvider {
    static var previews: some View {
        GridCardView(item: .init(name: "сыр Ламбер 500/0 230г", image: "FirstItemImage", price: 199.0, discount: 0.502, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.1", tag: .init(color: Color.designColor.saleTag, text: "Удар по ценам")), onItemCartAdd: {item in}, onItemCartDelete: {item in})
    }
}
