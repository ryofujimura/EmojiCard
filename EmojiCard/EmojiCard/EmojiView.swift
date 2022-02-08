//
//  EmojiView.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/6/22.
//

import SwiftUI

struct EmojiView: View {
//    let emojiAPI = EmojiAPI()
    @ObservedObject var emojiAPI = EmojiAPI()
//    var emojicharacter : EmojiData { emojiAPI.emojidatas.randomElement()!}
    var body: some View {
//        List(emojiAPI.emojidatas) {emojidata in
//            HStack{
//                Text(emojidata.character)
//            }
//        }
//        .onAppear{ emojiAPI.fetch() }

//        VStack {
//            Text(emojicharacter.unicodeName)
//            VStack {
//                Text("HELLO")
//            }
//            .onAppear{ emojiAPI.fetch() }
//        }
        NavigationView{
            List{
                ForEach(emojiAPI.emojidatas, id: \.self) { emojidata in
                    HStack{
//                        Text(emojidata.slug)
                        Text(emojidata.character)
//                        Text(emojidata.unicodeName)
//                        Text(emojidata.codePoint)
//                        Text(emojidata.group)
//                        Text(emojidata.subGroup)
                    }
                    .padding(3)
                }

            }
            .background(Color.clear)
            .navigationTitle("Emojis")
            .onAppear{ emojiAPI.fetch() }
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView()
    }
}
