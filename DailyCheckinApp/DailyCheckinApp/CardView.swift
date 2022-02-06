//
//  CardView.swift
//  DailyCheckinApp
//
//  Created by ryo fuj on 2/3/22.
//

import SwiftUI
import UIKit

struct CardView: View {
    
    var emojis = [""]
    var body: some View {
        ZStack {
            //background blur
            Color.white
            ForEach(emojis, id:\.self) { emoji in
                Text(emoji).modifier(EmojiModifier())
            }
        }
        .modifier(CardModifier())
    }
}

struct CardModifier : ViewModifier {
    let screen = UIScreen.main.bounds
    func body(content: Content) -> some View {
        content
            .frame(width: screen.width - 30, height: 200)
            .mask(RoundedRectangle(cornerRadius: 15).opacity(0.9))
            .shadow(color: Color.black.opacity(0.2), radius: 10)
    }
}

struct EmojiModifier : ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .font(.system(size: 200.0))
                .frame(width: 300)
                .position(x: .random(in: 0...proxy.size.width/1.5),
                          y: .random(in: 0...proxy.size.height))
                .blur(radius: 50)
        }
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
