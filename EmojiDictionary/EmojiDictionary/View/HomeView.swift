//
//  HomeView.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/10/22.
//

import SwiftUI

//let screen = UIScreen.main.bounds

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showEmoji: Bool = false
    
    let emoji: EmojiModel
  
    var body: some View {
        ZStack {
            Color.gray
            VStack{
                ZStack{
                    emojiCard
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(emoji: dev.emoji)
    }
}

extension HomeView{
    private var emojiCard: some View{
        List{
            ForEach(vm.allEmoji){ emoji in
                EmojiCard(emoji: emoji, showEmojiCard: false)
                    .listRowInsets(.init())
            }
        }
    }
    
    private var emojiCardDetail: some View {
        VStack{
            Text(emoji.character)
            Text(emoji.unicodeName)
            Text(emoji.subGroup)
            Text(emoji.group)
        }
    }
}
