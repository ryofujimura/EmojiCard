//
//  HomeView.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/10/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.homeBackcgroundView.ignoresSafeArea()
            VStack {
                ForEach(1..<100, id: \.self) { n in
                    Text("\(n)")
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
