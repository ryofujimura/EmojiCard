//
//  Emoji?Background.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/8/22.
//

import SwiftUI

struct EmojiBackground: View {
    @State var isAnimating = false
    @ObservedObject var emojiAPI = EmojiAPI()
    
    var animation: Animation {
        .interpolatingSpring(stiffness: 1, damping: 1)
                    .repeatForever()
                    .delay(isAnimating ? .random(in: 0...0.1) : 0)
                    .speed(isAnimating ? .random(in: 0.5...2) : 0)
    }
    
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var textField = true
    
//    ForEach(emojiAPI.shuffled().prefix(500)) { emojidata in
    //                        Text(emojidata.character)
    var body: some View {
        GeometryReader { proxy in
            HStack (spacing: 0) {
                Color.red.frame(width: proxy.size.width*0.05)
                ScrollView (.vertical, showsIndicators: false){
                    ForEach(emojiAPI.emojidatas.shuffled().prefix(200)) { char in
                        Button{
                            newWord = char.character
                            addNewWord()
                            print(usedWords)
                        } label: {
                            Text(char.character).font(.system(size: proxy.size.width*0.1))
                        }
                    }
                }
                .frame(width: proxy.size.width*0.1)
                CardView().frame(width: proxy.size.width*0.7)
                ScrollView (.vertical, showsIndicators: false){
                    ForEach(emojiAPI.emojidatas.shuffled().prefix(200)) { char in
                        Button{
                            newWord = char.character
                            addNewWord()
                            print(usedWords)
                        } label: {
                            Text(char.character).font(.system(size: proxy.size.width*0.1))
                        }
                    }
                }
                	.frame(width: proxy.size.width*0.1)
                Color.red.frame(width: proxy.size.width*0.05)
            }
        }
        .ignoresSafeArea()
        .onAppear{
            emojiAPI.fetch()
        }
    }
    func addNewWord() {
        let answer = newWord
        guard answer.count > 0 else { return }
        usedWords.append(answer)
//        newWord = ""
    }
}



struct EmojiBackground_Preview: PreviewProvider {
    static var previews: some View{
        EmojiBackground()
    }
}
