//
//  CardView.swift
//  DailyCheckinApp
//
//  Created by ryo fuj on 2/3/22.
//

import SwiftUI
import UIKit

struct CardView: View {
    let screen = UIScreen.main.bounds
    @State private var date = Date()
    @State private var todaysnote: String = ""
    
    var body: some View {
        ZStack {
            //background blur
            GeometryReader { proxy in
                ZStack{
                    Color.white
                    Text("🦞")
                        .font(.system(size: 200.0))
                        .frame(width: 300)
                        .position(x: .random(in: 0...proxy.size.width/1.5),
                                  y: .random(in: 0...proxy.size.height))
                    
                    .blur(radius: 50)
                }
            }
        }
        .frame(width: screen.width - 30, height: 200)
        .mask(RoundedRectangle(cornerRadius: 15).opacity(0.9))
        .shadow(color: Color.black.opacity(0.2), radius: 10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
