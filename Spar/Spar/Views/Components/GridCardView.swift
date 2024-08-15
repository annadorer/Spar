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
    private let onItemCartAdd: @MainActor (UUID, ItemUnit, Double) -> Void
    private let onItemCartDelete: @MainActor (UUID) -> Void
    
    init(item: Item,
         onItemCartAdd: @escaping @MainActor (UUID, ItemUnit, Double) -> Void,
         onItemCartDelete: @escaping @MainActor (UUID) -> Void,
         selectedUnit: SelectedAmount?) {
        _item = State(initialValue: item)
        _selectedUnit = State(initialValue: selectedUnit?.unit ?? item.units.first ?? .pcs)
        _selectedAmount = State(initialValue: selectedUnit?.count ?? 0.0)
        self.onItemCartAdd = onItemCartAdd
        self.onItemCartDelete = onItemCartDelete
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
                
                if let formattedDiscount = item.formattedDiscount {
                    Text(formattedDiscount)
                        .foregroundColor(Color.designColor.sale)
                        .font(.saleText())
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
                .font(.caption())
                .foregroundColor(Color.designColor.itemName)
                .padding(.horizontal, 8)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
        GridCardView(item:
                .init(name: "сыр Ламбер 500/0 230г",
                      image: "FirstItemImage",
                      price: 199.0,
                      discount: 0.502,
                      units: [.pcs, .kg],
                      ratingNumber: "4.1",
                      tag: .sale),
                     onItemCartAdd: { _, _, _ in },
                     onItemCartDelete: { _ in },
                     selectedUnit: nil)
    }
}
