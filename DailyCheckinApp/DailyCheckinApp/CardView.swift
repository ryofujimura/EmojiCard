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
    @AppStorage("note") var note: String?
    
    @State private var isShowingAnswer = false

    var body: some View {
        ZStack {
            CardBackgroundView()

            VStack{
                HStack {
                    Text("Today's date: ")
                    Spacer()
                    Text(date, style: .date)
                }

                TextField("Express your self with emojis", text: $todaysnote){
                    note = todaysnote
                }

//                .textFieldStyle(DefaultTextFieldStyle())
//                .multilineTextAlignment(.trailing)
                .frame(height: 100)
//                Text(note ?? "")
                Spacer()
            }
            .foregroundColor(Color.white)
            .padding()
        }
        .frame(width: screen.width - 60, height: 180)
        .mask(RoundedRectangle(cornerRadius: 15).opacity(0.9))
        .shadow(radius: 7)
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
