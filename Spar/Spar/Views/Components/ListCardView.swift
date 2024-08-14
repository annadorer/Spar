//
//  ListCardView.swift
//  Spar
//
//  Created by Anna on 11.08.2024.
//

import SwiftUI
import UISystem

@MainActor
struct ListCardView: View {
    
    @State private var selectedAmount: Double
    @State private var item: Item
    @State private var selectedUnit: ItemUnit
    private var onItemCartAdd: @MainActor (UUID, ItemUnit, Double) -> Void
    private var onItemCartDelete: @MainActor (UUID) -> Void
    
    init(item: Item, onItemCartAdd: @MainActor @escaping (UUID, ItemUnit, Double) -> Void, onItemCartDelete: @MainActor @escaping (UUID) -> Void, selectedUnit: SelectedAmount?) {
        self._item = State(initialValue: item)
        self._selectedUnit = State(initialValue: selectedUnit?.selectedUnit ?? item.units.first!)
        _selectedAmount = State(initialValue: selectedUnit?.selectedCount ?? 0.0)
        self.onItemCartAdd = onItemCartAdd
        self.onItemCartDelete = onItemCartDelete
    }
    
    var body: some View {
        HStack {
            top
            bottom
        }
        .frame(width: 375, height: 176)
        .background(Color.designColor.appBackground)
    }
    
    var top: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.image)
                    .frame(width: 168, height: 168)
                if (item.discount != nil) {
                    Text(String(format: "%.2f", item.discount!).replacingOccurrences(of: "0.", with: "").appending("%"))
                        .foregroundColor(Color.designColor.sale).font(.saleText())
                }
            }
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
    }
    
    var bottom: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 2) {
                Image.designIcon.rating
                Text(item.ratingNumber)
                    .font(.caption())
                Text("|")
                    .foregroundColor(Color.designColor.unitSelector)
                if item.review != nil {
                    Text(item.reviewString(for: item.review!))
                        .font(.caption()).foregroundColor(Color.designColor.unitSelector)
                }
            }
            .padding(.top, 8)
            Text(item.name)
                .font(.caption()).foregroundColor(Color.designColor.itemName)
                .padding(.horizontal, 4)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            if item.country != nil {
                Text(item.country!.countryName.appending(item.country!.flag))
                    .font(.caption()).foregroundColor(Color.designColor.unitSelector)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 44)
                
            }
            Spacer()
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
                    .padding([.horizontal, .bottom], 4)
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
                        .padding([.bottom, .trailing], 8)
                    }
                }
            }
        }
        .overlay(
            ActionListView()
                .padding(.top, 8)
                .padding(.horizontal, 4),
            alignment: .topTrailing)
    }
}

struct ListCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListCardView(item: .init(name: "сыр Ламбер 500/0 230г", image: "FirstItemImage", price: 199.0, discount: 0.502, units: [.init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1), .init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 0.1)], ratingNumber: "4.1", tag: .init(color: Color.designColor.saleTag, text: "Удар по ценам")), onItemCartAdd: {id,unit,amount in}, onItemCartDelete: {id in}, selectedUnit: nil)
    }
}
