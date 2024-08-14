//
//  FetchDataServiceProtocol.swift
//  Spar
//
//  Created by Anna on 12.08.2024.
//

import Combine

protocol FetchDataService {
    func fetch() async -> any Collection<Item>
}
