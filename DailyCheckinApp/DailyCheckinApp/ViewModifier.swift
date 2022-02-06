//
//  ViewModifier.swift
//  DailyCheckinApp
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

struct CardModifier : ViewModifier {
    let screen = UIScreen.main.bounds
    func body(content: Content) -> some View {
        content
            .frame(width: screen.width - 30, height: 200)
            .mask(RoundedRectangle(cornerRadius: 15).opacity(0.9))
            .shadow(color: Color.black.opacity(0.2), radius: 10)
    }
}

struct EmojiModifier : ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .font(.system(size: 200.0))
                .frame(width: 300)
                .position(x: .random(in: 0...proxy.size.width/1.5),
                          y: .random(in: 0...proxy.size.height))
                .blur(radius: 50)
        }
    }
}
