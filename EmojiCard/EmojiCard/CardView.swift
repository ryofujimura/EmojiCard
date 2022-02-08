//
//  CardView.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/6/22.
//

import SwiftUI

struct CardView: View {
    
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var textField = true
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    Color.background
                    ForEach(usedWords, id:\.self) { emoji in
                        if emoji.containsOnlyEmoji {
                            Text(emoji)
                                .animation(Animation.easeInOut)
                                .modifier(EmojiModifier())
                        }
                    }
                }
                .modifier(CardModifier())
                Button(action: {
                    textField = false
                    addNewWord()
                }) {
                    Rectangle()
                        .modifier(EntireScreen())
                }
                TextFieldDynamicWidth(title: "Enter Emoji", text: $newWord)
                    .onSubmit { addNewWord() }
            }
            .aspectRatio(2.5, contentMode: .fit)
            
            ZStack {
                Color.background
                ForEach(usedWords, id:\.self) { emoji in
                    if emoji.containsOnlyEmoji {
                        Text(emoji)
                            .animation(Animation.easeInOut)
                            .modifier(EmojiModifier())
                    }
                }
            }
            .modifier(CardModifier())
            .aspectRatio(5, contentMode: .fit)
        }
    }
    
    func addNewWord() {
        let answer = newWord
        guard answer.count > 0 else { return }
//        withAnimation{usedWords.insert(answer, at: 0)}
        
        usedWords.append(answer)
        newWord = ""
    }
}




struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

