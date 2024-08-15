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
    @Binding private var selectedAmount: Double
    @Binding private var selectedUnit: ItemUnit

    private let onPlusClick: @MainActor () -> Void
    private let onMinusClick: @MainActor () -> Void
    private let onUnitChange: @MainActor () -> Void
    
    init(selectedAmount: Binding<Double>,
         selectedUnit: Binding<ItemUnit>,
         itemAmounts: [ItemUnit],
         basePrice: Double,
         onPlusClick: @MainActor @escaping () -> Void,
         onMinusClick: @MainActor @escaping () -> Void,
         onUnitChange: @MainActor @escaping () -> Void) {
        _selectedAmount = selectedAmount
        _selectedUnit = selectedUnit
        _itemAmounts = State(initialValue: itemAmounts)
        _basePrice = State(initialValue: basePrice)
        self.onPlusClick = onPlusClick
        self.onMinusClick = onMinusClick
        self.onUnitChange = onUnitChange
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.black)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.designColor.unitSelector)], for: .normal)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Picker(LocalizedStringKey.init(""), selection: $selectedUnit) {
                ForEach(itemAmounts, id: \.self) { unit in
                    Text(unit.rawValue.lowercased()).tag(unit)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .pickerStyle(SegmentedPickerStyle())
            HStack(alignment: .center) {
                Button(action: {
                    selectedAmount = Double(String(format: "%.3f", (selectedAmount - addingCount * selectedUnit.addingCoefficient))) ?? 0.0
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
                    Text(String(format: selectedUnit.priceCoefficient == 1.0 ? "%.1f %@" : "%.0f %@", selectedAmount, selectedUnit.rawValue))
                        .font(.priceCents())
                        .foregroundColor(Color.white).bold()
                    Text("~\(String(format: "%.2f", basePrice * selectedAmount * selectedUnit.priceCoefficient).appending(UI.Strings.currency))")
                        .font(.caption)
                        .foregroundColor(Color.white)
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
        QuantitySelectorView(selectedAmount: .constant(1.0),
                             selectedUnit: .constant(.kg),
                             itemAmounts: [.kg, .pcs],
                             basePrice: 199.0,
                             onPlusClick: {},
                             onMinusClick: {},
                             onUnitChange: {})
    }
}
