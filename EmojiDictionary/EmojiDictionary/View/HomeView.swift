//
//  HomeView.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/10/22.
//

import SwiftUI

let screen = UIScreen.main.bounds
//let data = (1...250).map { "\($0)" }

struct HomeView: View {
    @State var isAnimating = false
    @State var offset:CGFloat = 0
    @State private var usedWords = [String]()
    @State private var newWord = ""
    
    @EnvironmentObject var emojiAPI: EmojiAPI
    let emojiCharacter = emojiAPI.emojidatas.shuffled().prefix(20)
    
    var body: some View {
        ZStack {
            Color.homeBackcgroundView
            VStack (spacing: 10) {
                ForEach(0..<10, id: \.self ) { emoji in
                    Text("s")
//                        .foregroundColor(Color.white)
////                    23
//                    Text(emoji.character)
//                    HStack (spacing: 10){
//                        ForEach(0..<5, id: \.self) { nnn in
////                            50
//                            Button(
//                                action: {  addNewWord()  },
//                                label: { Text(emoji.character) }
////                                    .font(.system(size: 20)) }
////          emojiAPI.emojidatas.shuffled().prefix(1)        Color.red              Text("🐳").font(.system(size: 20))
//                            )
//                        }.frame(width: 20, height: 20)
//                    }
//                    .offset(x: self.isAnimating ? .random(in: -300...300) : .random(in: -300...300))
//                    .animation(Animation.linear(duration: 20).repeatForever(), value: self.isAnimating)
                }
            }
        }
        .onAppear{
            self.isAnimating = true
            emojiAPI.fetch()
        }
        .ignoresSafeArea()
    }
    
    func addNewWord() {
        let answer = newWord
        guard answer.count > 0 else { return }

        usedWords.append(answer)
        newWord = ""
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(EmojiAPI())
    }
}
