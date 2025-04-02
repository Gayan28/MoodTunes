//
//  MoodTunesApp.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-02.
//

import SwiftUI

@main
struct MoodTunesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
