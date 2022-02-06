//
//  ViewModifier.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/6/22.
//

import Foundation
import UIKit
import SwiftUI

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var emojis: [Character] { filter { $0.isEmoji } }
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
}

extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}

struct TextFieldModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.neumorphictextColor)
            .background(Color.background)
            .cornerRadius(6)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}

struct CardModifier : ViewModifier {
    let screen = UIScreen.main.bounds
    func body(content: Content) -> some View {
        content
            .frame(width: screen.width - 30, height: 200)
            .mask(RoundedRectangle(cornerRadius: 15).opacity(0.9))
//            .shadow(color: Color.black.opacity(0.9), radius: 10)
    }
}

struct EmojiModifier : ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .font(.system(size: 150.0))
                .frame(width: 300)
                .position(x: .random(in: 0...proxy.size.width),
                          y: .random(in: 0...proxy.size.height))
                .blur(radius: 50)
        }
    }
}
