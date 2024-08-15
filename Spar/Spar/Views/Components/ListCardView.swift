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
    
    private let onItemCartAdd: @MainActor (UUID, ItemUnit, Double) -> Void
    private let onItemCartDelete: @MainActor (UUID) -> Void
    
    init(item: Item,
         selectedUnit: SelectedAmount?,
         onItemCartAdd: @MainActor @escaping (UUID, ItemUnit, Double) -> Void,
         onItemCartDelete: @MainActor @escaping (UUID) -> Void) {
        _item = State(initialValue: item)
        _selectedUnit = State(initialValue: selectedUnit?.unit ?? item.units.first ?? .pcs)
        _selectedAmount = State(initialValue: selectedUnit?.count ?? 0.0)
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
                
                if let formattedDiscount = item.formattedDiscount {
                    Text(formattedDiscount)
                        .foregroundColor(Color.designColor.sale)
                        .font(.saleText())
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
                if let review = item.review {
                    Text(item.reviewString(for: review))
                        .font(.caption())
                        .foregroundColor(Color.designColor.unitSelector)
                }
            }
            .padding(.top, 8)
            
            Text(item.name)
                .font(.caption())
                .foregroundColor(Color.designColor.itemName)
                .padding(.horizontal, 4)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            if let country = item.country {
                Text(country.rawValue.appending(country.flag))
                    .font(.caption())
                    .foregroundColor(Color.designColor.unitSelector)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 44)
            }
            
            Spacer()
            
            Group {
                if !selectedAmount.isZero {
                    QuantitySelectorView(selectedAmount: $selectedAmount,
                                         selectedUnit: $selectedUnit,
                                         itemAmounts: item.units,
                                         basePrice: item.priceWithDiscount,
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
        ListCardView(item:
                .init(name: "сыр Ламбер 500/0 230г",
                      image: "FirstItemImage",
                      price: 199.0,
                      discount: 0.502,
                      units: [.pcs, .kg],
                      ratingNumber: "4.1",
                      tag: .sale),
                     selectedUnit: nil,
                     onItemCartAdd: { _, _, _ in },
                     onItemCartDelete: { _ in })
    }
}
