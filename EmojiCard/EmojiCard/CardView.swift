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
    @FocusState private var textField: Bool
    
    var body: some View {
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
            TextField("Enter Today's Emoji", text: $newWord)
                .modifier(TextFieldModifier())
                .focused($textField)
                .onSubmit { addNewWord() }
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

