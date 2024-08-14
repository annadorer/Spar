//
//  Icons.swift
//  
//
//  Created by Anna on 08.08.2024.
//

import SwiftUI

public extension Image {
    
    static let designIcon = DesignIcons()
    
    struct DesignIcons {
        public let activeFavorites = Image("ActiveFavoritesIcon", bundle: .module)
        public let favorites = Image("FavoritesIcon", bundle: .module)
        public let grid = Image("GridIcon", bundle: .module)
        public let list = Image("ListIcon", bundle: .module)
        public let orderList = Image("OrderListIcon", bundle: .module)
        public let rating = Image("RatingIcon", bundle: .module)
        public let shoppingBasket = Image("ShoppingBasketIcon", bundle: .module)
    }
}
