//
//  SwiftUIView.swift
//  Spar
//
//  Created by Anna on 10.08.2024.
//

import SwiftUI
import UISystem

struct QuantitySelectorView: View {
    
    @State private var itemAmounts: [ItemUnit]
    @State private var addingCount: Double = 1
    @State private var basePrice: Double
    @State private var onPlusClick: () -> Void
    @State private var onMinusClick: () -> Void
    @State private var onUnitChange: () -> Void
    
    @Binding private var selectedAmount: Double
    @Binding private var selectedUnit: ItemUnit
    
    init(selectedAmount: Binding<Double>, selectedUnit: Binding<ItemUnit>, itemAmounts: [ItemUnit], basePrice: Double,  onPlusClick: @escaping () -> Void, onMinusClick: @escaping () -> Void, onUnitChange: @escaping () -> Void) {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.black)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.designColor.unitSelector)], for: .normal)
        _selectedAmount = selectedAmount
        _selectedUnit = selectedUnit
        self._onPlusClick = State(initialValue: onPlusClick)
        self._onMinusClick = State(initialValue: onMinusClick)
        self._onUnitChange = State(initialValue: onUnitChange)
        self._itemAmounts = State(initialValue: itemAmounts)
        self._basePrice = State(initialValue: basePrice)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Picker(LocalizedStringKey.init(""), selection: $selectedUnit) {
                ForEach(itemAmounts, id: \.unit) { unit in
                    Text(unit.unit.lowercased()).tag(unit)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .pickerStyle(SegmentedPickerStyle())
            HStack(alignment: .center) {
                Button(action: {
                    selectedAmount -= addingCount * selectedUnit.addingCoefficient
                    if (selectedAmount <= 0) {
                        selectedAmount = 0
                    }
                    onMinusClick()
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.white).bold()
                }
                .padding(.horizontal, 8)
                VStack(alignment: .center, spacing: 0) {
                    Text(String(format: selectedUnit.priceCoefficient == 1.0 ? "%.1f %@" : "%.0f %@", selectedAmount, selectedUnit.unit))
                        .font(.priceCents()).foregroundColor(Color.white).bold()
                    Text("~\(String(format: "%.2f", basePrice * selectedAmount * selectedUnit.priceCoefficient)) ₽") //TODO локалайзед
                        .font(.caption).foregroundColor(Color.white)
                }
                Button(action: {
                    selectedAmount += addingCount * selectedUnit.addingCoefficient
                    onPlusClick()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white).bold()
                }
                .padding(.horizontal, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: 36)
            .background(Color.designColor.button)
            .cornerRadius(40)
            .onChange(of: selectedUnit, perform: { newValue in
                switch newValue.addingCoefficient {
                case 1:
                    selectedAmount = selectedAmount.rounded(.up)
                default:
                    break
                }
                onUnitChange()
            })
        }
    }
}

struct QuantitySelectorView_Previews: PreviewProvider {
    static var previews: some View {
        QuantitySelectorView(selectedAmount: .constant(1.0), selectedUnit: .constant(.init(unit: "kg", priceCoefficient: 1, addingCoefficient: 1)), itemAmounts: [.init(unit: "Кг", priceCoefficient: 1, addingCoefficient: 1), .init(unit: "Шт", priceCoefficient: 2.5, addingCoefficient: 1)], basePrice: 199.0, onPlusClick: {}, onMinusClick: {}, onUnitChange: {})
    }
}
