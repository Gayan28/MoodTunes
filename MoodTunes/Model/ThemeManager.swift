//
//  ThemeManager.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-15.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isLightMode: Bool = false

    var background: Color {
        isLightMode ? Color.white : Color(hex: "#0F0817")
    }

    var textPrimary: Color {
        isLightMode ? Color.black : Color.white
    }

    var cardOverlay: Color {
        isLightMode ? Color.white.opacity(0.4) : Color.black.opacity(0.5)
    }

    var tabBar: Color {
        isLightMode ? Color(white: 0.95) : Color.black.opacity(0.9)
    }
}
