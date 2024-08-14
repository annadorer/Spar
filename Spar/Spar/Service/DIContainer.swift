//
//  DIContainer.swift
//  Spar
//
//  Created by Anna on 12.08.2024.
//

import Swinject

extension Container {
    
    static let shared = Container()
    
    static var fetchDataService: FetchDataService {
        shared.resolve(FetchDataService.self)!
    }
}
