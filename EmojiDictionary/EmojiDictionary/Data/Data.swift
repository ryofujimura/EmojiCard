//
//  Data.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/10/22.
//

import Foundation
import SwiftUI

/*
 API Url = https://emoji-api.com/emojis?access_key=a88b742ade10255237bc05ff3c17101da8c763cd
 JSON example
 [
 {
 "slug": "grinning-face",
 "character": "\ud83d\ude00",
 "unicodeName": "grinning face",
 "codePoint": "1F600",
 "group": "smileys-emotion",
 "subGroup": "face-smiling"
 },
 ]
 */
struct EmojiModel:  Codable, Hashable {
//    var id = UUID()
    let slug, character, unicodeName, codePoint: String
    let group, subGroup: String
    
    enum EmojiKeys: String, CodingKey {
        case slug, character, unicodeName, codePoint, group, subGroup
    }
    
    func updateEmoji(emoji: String) -> EmojiModel {
        return EmojiModel(slug: emoji, character: character, unicodeName: unicodeName, codePoint: codePoint, group: group, subGroup: subGroup)
    }
    
    var currentEmojiSlug: String {
        return slug
    }
    var currentEmojiCharacter: String {
        return character
    }
    var currentEmojiUnicode: String {
        return unicodeName
    }
    var currentEmojiCodePoint: String {
        return codePoint
    }
    var currentEmojiGroup: String {
        return group
    }
    var currentEmojiSubGroup: String {
        return subGroup
    }
}

//class EmojiAPI : ObservableObject {
//    @Published var emojiModel: [EmojiModel] = []
//    
//    func fetch() {
//        guard let url = URL(string: "https://emoji-api.com/emojis?access_key=a88b742ade10255237bc05ff3c17101da8c763cd") else { return }
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else { return }
//            do {
//                let emojiModel = try JSONDecoder().decode([EmojiModel].self, from: data)
//                DispatchQueue.main.async {
//                    self?.emojiModel = emojiModel
//                }
//            } catch { return }
//        }
//        task.resume()
//    }
//}

