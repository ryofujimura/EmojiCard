//
//  Data.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/10/22.
//

import Foundation
import SwiftUI

extension Color {
    static let homeBackcgroundView = Color(red:23/256, green: 31/256, blue: 62/256)
    static let homeCardView = Color(red: 43/256, green: 46/256, blue: 59/256)
    static let menuCardView = Color(red: 23/256, green: 31/256, blue: 62/256)
    static let cardOnMenuView = Color(red: 46/256,  green: 53/256, blue: 79/256)
    static let emojiCardView = Color(red: 178/256, green: 178/256, blue: 178/256)

    static let titleText = Color(red: 256/256, green: 256/256, blue: 256/256)
    static let subTitleText = Color(red: 178/256, green: 178/256, blue: 178/256)
    static let unicodeText = Color(red: 138/256, green: 138/256, blue: 138/256)
}

class EmojiCharacter : ObservableObject {
    @Published var emojiCharacter: [EmojiData] = []
    
}

class EmojiAPI : ObservableObject {
    @Published var emojidatas: [EmojiData] = []
    
    func fetch() {
        guard let url = URL(string: "https://emoji-api.com/emojis?access_key=a88b742ade10255237bc05ff3c17101da8c763cd") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let emojidatas = try JSONDecoder().decode([EmojiData].self, from: data)
                DispatchQueue.main.async {
                    self?.emojidatas = emojidatas
                }
            } catch { return }
        }
        task.resume()
    }
}

struct EmojiData: Hashable, Codable, Identifiable {
    var id = UUID()
    let slug : String
    let character : String
    let unicodeName : String
    let codePoint : String
    let group : String
    let subGroup : String
}
