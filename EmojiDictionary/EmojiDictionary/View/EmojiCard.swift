//
//  EmojiCard.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/16/22.
//

import SwiftUI

struct EmojiCard: View {
    let emoji: EmojiModel
    let showEmojiCard: Bool
    
    var body: some View {
        ZStack{
            cardView
            VStack(spacing: 0){
                Spacer()
                emojiCharacter
                    .frame(height: 90)
                emojiDescription
                emojiGroup
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.25)
    }
}

struct EmojiCard_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            EmojiCard(emoji: dev.emoji, showEmojiCard: true)
                .previewLayout(.sizeThatFits)
            EmojiCard(emoji: dev.emoji, showEmojiCard: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension EmojiCard {
    private var cardView: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color.emojiCardView)
    }

    private var emojiCharacter: some View {
        HStack(spacing: 0) {
            Text(emoji.character)
                .font(.system(size: 100))
//                .padding(.leading, 5.0)
                .padding([.top, .bottom, .trailing], -6.0)
            Spacer()
        }
    }
    
    private var emojiDescription : some View {
        ZStack{
            Text(emoji.codePoint)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.codePointText)
                .offset(x: 60, y: -40)
            Text(emoji.unicodeName.capitalized)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.titleText)
        }
    }
    
    private var emojiGroup :some View {
        HStack(spacing: 0){
            Spacer()
            Button{} label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.cardOnMenuView)
                    .overlay(
                        Text(emoji.group.capitalized)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(Color.titleText)
                        )
            }
            Spacer()
            Button{} label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.cardOnMenuView)
                    .overlay(
                        Text(emoji.subGroup.capitalized)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(Color.titleText)
                        )
            }
            Spacer()
        }
    }
}
