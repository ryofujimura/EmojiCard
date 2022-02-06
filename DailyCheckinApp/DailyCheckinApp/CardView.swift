//
//  CardView.swift
//  DailyCheckinApp
//
//  Created by ryo fuj on 2/3/22.
//

import SwiftUI

struct CardView: View {
    
    @State private var usedWords = [String]()
    @State private var newWord = ""
    
    var body: some View {
        VStack {
            TextField("Enter Emoji", text: $newWord)
                .modifier(TextFieldModifier())
                .padding()
            ZStack {
                ForEach(usedWords, id:\.self) { emoji in
                    if emoji.containsOnlyEmoji {
                        Text(emoji).modifier(EmojiModifier())
                    }
                }
            }
            .modifier(CardModifier())
        }
        .onSubmit { addNewWord() }
    }
    
    func addNewWord() {
        let answer = newWord
        guard answer.count > 0 else { return }
        withAnimation{usedWords.insert(answer, at: 0)}
        
        usedWords.append(answer)
        newWord = ""
    }
}




struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
