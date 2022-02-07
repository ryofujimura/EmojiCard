//
//  ContentView.swift
//  EmojiCard
//
//  Created by ryo fuj on 2/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack{
                CardView()
                    .frame(height: 160)
                Spacer()
                Rectangle()
                    .modifier(EntireScreen())
            }
//            EmojiView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
