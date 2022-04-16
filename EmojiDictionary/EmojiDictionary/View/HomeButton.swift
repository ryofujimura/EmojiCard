//
//  HomeButton.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/16/22.
//

import SwiftUI

struct HomeButton: View {
    let buttonTitle: String
    let showEmojiCard: Bool
    
    var body: some View {
        Button{} label: {
            ZStack{
                roundedRectangle
                textLabel
            }
            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.1)
        }
    }
}

struct HomeButton_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HomeButton(buttonTitle: "Todays Emoji", showEmojiCard: true)
                .previewLayout(.sizeThatFits)
            HomeButton(buttonTitle: "Todays Emoji", showEmojiCard: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension HomeButton {
    private var roundedRectangle : some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color("menuCardView"))
    }
    
    private var textLabel : some View {
        HStack{
            Spacer()
            Text("😁")
                .font(.system(size: 45))
            Spacer()
            Text(buttonTitle)
                .font(.system(size: 25))
            Spacer()
            Text("💸")
                .font(.system(size: 45))
            Spacer()
        }
        .foregroundColor(Color("titleText"))
    }
}
