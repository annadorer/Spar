//
//  FetchDataServiceProtocol.swift
//  Spar
//
//  Created by Anna on 12.08.2024.
//

protocol FetchDataServiceProtocol {
    func fetch() async -> [Item]
}
