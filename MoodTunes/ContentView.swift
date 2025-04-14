//
//  ContentView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-02.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

struct ContentView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some View {
        NavigationStack {
            SplashScreen()
        }
    }
}

#Preview {
    ContentView()
}
