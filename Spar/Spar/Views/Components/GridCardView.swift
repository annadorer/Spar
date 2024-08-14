//
//  GridCardView.swift
//  
//
//  Created by Anna on 08.08.2024.
//

import SwiftUI
import UISystem

@MainActor
struct GridCardView: View {
    
    @State private var selectedAmount: Double
    @State private var selectedUnit: ItemUnit
    @State private var item: Item
    private var onItemCartAdd: @MainActor (UUID, ItemUnit, Double) -> Void
    private var onItemCartDelete: @MainActor (UUID) -> Void
    
    init(item: Item, onItemCartAdd: @escaping @MainActor (UUID, ItemUnit, Double) -> Void, onItemCartDelete: @escaping @MainActor (UUID) -> Void, selectedUnit: SelectedAmount?) {
        self._item = State(initialValue: item)
        self.onItemCartAdd = onItemCartAdd
        self.onItemCartDelete = onItemCartDelete
        self._selectedUnit = State(initialValue: selectedUnit?.selectedUnit ?? item.units.first!)
        _selectedAmount = State(initialValue: selectedUnit?.selectedCount ?? 0.0)
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
                        onItemCartAdd(item.id, selectedUnit, selectedAmount)
                                         },
                                         onMinusClick: {
                                             if (selectedAmount <= 0) {
                                                 onItemCartDelete(item.id)
                                             } else {
                                                 onItemCartAdd(item.id, selectedUnit, selectedAmount)
                                             }
                                         }, onUnitChange: {
                                             onItemCartAdd(item.id, selectedUnit, selectedAmount)
                                         })
                    .padding(.horizontal, 4)
                    .padding(.bottom, 6)
                } else {
                    HStack(spacing: 2) {
                        PriceWithDiscountView(item: item)
                        Spacer()
                        Button(action: {
                            selectedAmount += selectedUnit.addingCoefficient
                            onItemCartAdd(item.id, selectedUnit, selectedAmount)
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
        GridCardView(item: .init(name: "сыр Ламбер 500/0 230г", image: "FirstItemImage", price: 199.0, discount: 0.502, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.1", tag: .init(color: Color.designColor.saleTag, text: "Удар по ценам")), onItemCartAdd: {id,unit,amount in}, onItemCartDelete: {id in}, selectedUnit: nil)
    }
}
