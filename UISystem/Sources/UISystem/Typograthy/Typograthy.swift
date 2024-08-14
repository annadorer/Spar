//
//  Typograthy.swift
//  
//
//  Created by Anna on 08.08.2024.
//

import SwiftUI

public extension Font {
    
    static func caption(size: CGFloat = 12) -> Font {
        .system(size: size)
    }
    
    static func priceBig(size: CGFloat = 20) -> Font {
        .custom("CeraRoundPro-Bold", size: size)
    }
    
    static func priceCents(size: CGFloat = 16) -> Font {
        .custom("CeraRoundPro-Bold", size: size)
    }
    
    static func tagText(size: CGFloat = 10) -> Font {
        .system(size: size)
    }
    
    static func saleText(size: CGFloat = 16) -> Font {
        .custom("CeraRoundPro-Bold", size: size)
    }
    
    static func unitSelector(size: CGFloat = 14) -> Font {
        .system(size: size)
    }
    
    static func priceText(size: CGFloat = 14) -> Font {
        .custom("CeraRoundPro-Bold", size: size)
    }
    
}


