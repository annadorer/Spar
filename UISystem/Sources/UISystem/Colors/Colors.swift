//
//  Colors.swift
//  
//
//  Created by Anna on 08.08.2024.
//

import SwiftUI

public extension Color {
    
    static let designColor = DesignColor()
    
    struct DesignColor {
        public let button = Color("ButtonColor", bundle: .module)
        public let tagText = Color("TagTextColor", bundle: .module)
        public let appBackground = Color("AppBackgroundColor", bundle: .module)
        public let newTag = Color("NewTagColor", bundle: .module)
        public let saleTag = Color("SaleTagColor", bundle: .module)
        public let cardPriceTag = Color("CardPriceTagColor", bundle: .module)
        public let itemName = Color("ItemNameColor", bundle: .module)
        public let oldPrice = Color("OldPriceColor", bundle: .module)
        public let sale = Color("SaleTextColor", bundle: .module)
        public let unitSelector = Color("UnitSelectorColor", bundle: .module)
        public let shadow = Color("shadowColor", bundle: .module)
        public let buttonNavigationBlackground = Color("ButtonNavigationBackgroundColor", bundle: .module)
        public let divider = Color("DividerColor", bundle: .module)
        public let actionList = Color("ActionListColor", bundle: .module)
        
    }
}
