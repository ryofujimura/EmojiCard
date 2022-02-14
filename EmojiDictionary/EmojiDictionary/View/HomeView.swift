//
//  HomeView.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/10/22.
//

import SwiftUI

//let screen = UIScreen.main.bounds

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.gray
            VStack{
                Text("character: 🐣")
                Text("unicodeName: ")
                Text("codePoint")
                Text("group")
                Text("subGroup")
            }
            .foregroundColor(Color.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
