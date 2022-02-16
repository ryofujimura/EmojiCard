//
//  HomeViewModel.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/15/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allEmoji: [EmojiModel] = []
    @Published var potfolioEmoji: [EmojiModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.allEmoji.append(DeveloperPreview.instace.emoji)
            self.potfolioEmoji.append(DeveloperPreview.instace.emoji)
        }
    }
}
