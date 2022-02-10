//
//  Emoji.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/6/22.
//
import Foundation
import UIKit

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

//class EachEmojis : ObservableObject {
//    let emojiCharacter: [Any] = EmojiData()
//    init () {
//        self.emojiCharacter = EmojiData(slug: slug, character: Character, unicodeName: <#T##String#>, codePoint: <#T##String#>, group: <#T##String#>, subGroup: <#T##String#>)
////        emojiAPI.emojidatas.shuffled().prefix(30)
//    }
//}

struct EmojiData: Hashable, Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case slug
        case character
        case unicodeName
        case codePoint
        case group
        case subGroup
    }
    var id = UUID()
    var slug: String
    var character: String
    var unicodeName: String
    var codePoint: String
    var group: String
    var subGroup: String
}

//struct EmojiData: Hashable, Codable, Identifiable {
//    var id = UUID()
//    let slug : String
//    let character : String
//    let unicodeName : String
//    let codePoint : String
//    let group : String
//    let subGroup : String
//}
