//
//  SparApp.swift
//  Spar
//
//  Created by Anna on 08.08.2024.
//

import SwiftUI
import Swinject

@main
struct SparApp: App {
    
    init() {
        registerServices()
    }
    
    var body: some Scene {
        WindowGroup {
            ItemsScreen()
        }
    }
    private func registerServices() {
        Container.shared.register(FetchDataService.self) { _ in
            MockFetchDataService()
        }
    }
}
