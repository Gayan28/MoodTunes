//
//  MoodTunesApp.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-02.
//

import SwiftUI
import Firebase

@main
struct MoodTunesApp: App {
    @StateObject var authVM = AuthViewModel()
    @StateObject var themeManager = ThemeManager()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(themeManager)
        }
    }
}
