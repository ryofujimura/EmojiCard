//
//  ContentView.swift
//  DailyCheckinApp
//
//  Created by ryo fuj on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack{
                DatePickerView()
                CardView(card: Card.example)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
