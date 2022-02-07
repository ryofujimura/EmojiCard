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
    static let lightShadow = Color(red: 234 / 255, green: 239 / 255, blue: 246 / 255)
    static let darkShadow = Color(red: 183 / 255, green: 197 / 255, blue: 218 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}

struct TextFieldDynamicWidth: View {
    let title: String
    @Binding var text: String
    @State private var textRect = CGRect()
    
    var body: some View {
        ZStack {
            Text(text == "" ? title : text).background(GlobalGeometryGetter(rect: $textRect)).layoutPriority(1).opacity(0)
            HStack {
                TextField(title, text: $text)
                    .frame(width: textRect.width)
                    .modifier(TextFieldModifier())
            }
        }
    }
}

struct GlobalGeometryGetter: View {
    @Binding var rect: CGRect
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

struct TextFieldModifier : ViewModifier {
    let screen = UIScreen.main.bounds
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .submitLabel(.send)
            .padding()
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}

struct CardModifier : ViewModifier {
    let screen = UIScreen.main.bounds
    func body(content: Content) -> some View {
        content
            .aspectRatio(2, contentMode: .fit)
            .frame(width: screen.width - 50)
            .mask(RoundedRectangle(cornerRadius: 15).opacity(0.9))
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}

struct EntireScreen : ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .opacity(0.0)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct EmojiModifier : ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .font(.system(size: 150.0))
//                .frame(width: 300)
                .position(x: .random(in: 0...proxy.size.width),
                          y: .random(in: 0...proxy.size.height))
                .blur(radius: 50)
        }
    }
}

