//
//  EmojiView.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/6/22.
//

import SwiftUI

struct EmojiView: View {
    @StateObject var emojiAPI = EmojiAPI()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(emojiAPI.emojidatas, id: \.self) { emojidata in
                    HStack{
//                        Image("")
                        Text(emojidata.slug)
                        Text(emojidata.character)
                        Text(emojidata.unicodeName)
                        Text(emojidata.codePoint)
                        Text(emojidata.group)
                        Text(emojidata.subGroup)
                    }
                    .padding(3)
                }
            }
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
