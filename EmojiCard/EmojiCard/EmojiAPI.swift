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

//class EmojiAPI : ObservableObject {
//    @Published var emojidatas: [EmojiData] = []
//    func fetch() {
//        guard let url = URL(string: "\(String(describing: Bundle.main.path(forResource: "apipractice", ofType: "json")))") else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else { return }
//            do {
//                let emojidatas = try JSONDecoder().decode([EmojiData].self, from: data)
//                DispatchQueue.main.async {
//                    self?.emojidatas = emojidatas
//                }
//            } catch { return }
//        }
//        task.resume()
//    }
//}

struct EmojiData: Hashable, Codable {
    let slug : String
    let character : String
    let unicodeName : String
    let codePoint : String
    let group : String
    let subGroup : String
}
