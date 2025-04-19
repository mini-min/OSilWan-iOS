//
//  Challenge2App.swift
//  Challenge2
//
//  Created by mini on 4/12/25.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct Challenge2App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TrainingRecord.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    init() {
        try? Tips.configure()
    }
}
