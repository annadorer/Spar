//
//  String+Extension.swift
//  Spar
//
//  Created by Anna on 14.08.2024.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
