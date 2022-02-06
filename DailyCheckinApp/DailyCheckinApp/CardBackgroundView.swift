//
//  CardBackgroundView.swift
//  DailyCheckinApp
//
//  Created by ryo fuj on 2/5/22.
//

import SwiftUI

struct CardBackgroundView: View {

    let emojiList = [
        emojiColorChanger(emoji: "😁"),
        emojiColorChanger(emoji: "💸"),
        emojiColorChanger(emoji: "♒️"),
        emojiColorChanger(emoji: "㊙️"),
        emojiColorChanger(emoji: "🕋")
    ]
    
    
    var body: some View {
        GeometryReader { proxy in
            ZStack{
                Color.white
                ForEach(emojiList){ emoji in
                    Text(emoji.emoji)
                        .font(.system(size: 200.0))
                        .frame(width: 300)
                        .position(x: .random(in: 0...proxy.size.width),
                                  y: .random(in: 0...proxy.size.height))
                }
                .blur(radius: 50)
                Color.black
                    .opacity(0.4)
                
               
            }
//                .frame(height: proxy.size.height/3)
        }
    }
}

struct emojiColorChanger: Identifiable{
    var id = UUID()
    var emoji: String
}

struct CardBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackgroundView()
    }
}
