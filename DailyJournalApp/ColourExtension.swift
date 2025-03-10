//
//  ColourExtension.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 10.03.25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized = String(hexSanitized.dropFirst())
        }

        var hexColor: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&hexColor)

        let red = Double((hexColor & 0xFF0000) >> 16) / 255.0
        let green = Double((hexColor & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexColor & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

public let peachCustomColour = Color(hex: "#e86f6f")
public let babyMintColour = Color(hex: "#8cbdbb")
