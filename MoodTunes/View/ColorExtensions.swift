//
//  ColorExtensions.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-07.
//

import SwiftUI

extension Color {
    static let background = Color(hex: "0F0817")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB
            (r, g, b)
::contentReference[oaicite:9]{index=9}
 
