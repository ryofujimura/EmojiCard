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
    @State private var field = ""
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                Spacer()
                homeButton
                Spacer()
                if !showEmoji {
                    emojiCard
                }
                Spacer()
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(HomeViewModel())
    }
}

extension HomeView{
    private var emojiCard : some View {
        EmojiCard(
            emoji: DeveloperPreview.instace.emoji,
            showEmojiCard: false
        )
            .listRowInsets(.init())
    }
    
    private var emojiCardList: some View{
        List{
            ForEach(vm.allEmojis, id:\.self){ emoji in
                EmojiCard(emoji: emoji, showEmojiCard: false)
                    .listRowInsets(.init())
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var homeButton : some View {
        HomeButton(buttonTitle: "Todays Emoji", showEmojiCard: true)
    }
}
