//
//  EmojiDataService.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/16/22.
//

import Foundation
import Combine

class EmojiDataService {
    @Published var allEmojis: [EmojiModel]  = []
    var coinSubscription : AnyCancellable?
    init() {
        getEmoji()
    }
    
    private func getEmoji() {
        guard let url = URL(string: "https://emoji-api.com/emojis?access_key=a88b742ade10255237bc05ff3c17101da8c763cd") else { return }
        
        coinSubscription =  NetworkingManager.download(url: url)
            .decode(type: [EmojiModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedEmojis) in
                  self?.allEmojis = returnedEmojis
                  self?.coinSubscription?.cancel()
            })
    }
    
}
