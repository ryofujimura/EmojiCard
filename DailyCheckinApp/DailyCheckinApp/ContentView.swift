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
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            VStack{
//                DatePickerView()
                CardView()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
