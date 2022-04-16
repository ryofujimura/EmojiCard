//
//  HomeViewModel.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/15/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allEmojis: [EmojiModel] = []
    @Published var potfolioEmoji: [EmojiModel] = []

    private let dataService = EmojiDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    func addSubscribers() {
        dataService.$allEmojis
            .sink{ [weak self] (returnedEmojis) in
                self?.allEmojis  = returnedEmojis
            }
            .store(in: &cancellables)
    }
//    func downloadData() { }
}
