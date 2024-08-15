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
            ItemsScreen(viewModel: ItemsScreenViewModel(fetchDataService: Container.fetchDataService))
        }
    }
    private func registerServices() {
        Container.shared.register(FetchDataServiceProtocol.self) { _ in
            MockFetchDataService()
        }
    }
}
