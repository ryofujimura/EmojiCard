//
//  CardView.swift
//  DailyCheckinApp
//
//  Created by ryo fuj on 2/3/22.
//

import SwiftUI
import UIKit

struct CardView: View {

    let card: Card
    let screen = UIScreen.main.bounds
    
    @State private var date = Date()
    @State private var todaysnote: String = ""
    @AppStorage("note") var note: String?
//    @FocusState private var nameIsFocused: Bool
    
    @State private var isShowingAnswer = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.green)

            VStack (){
                HStack {
                    Text("Today's date: ")
                    Spacer()
                    Text(date, style: .date)
                        .foregroundColor(Color.gray)
                }

                HStack{
                    Text("Note")
                        .foregroundColor(Color.black)
                    Spacer()
                    TextField("Add today's note", text: $todaysnote){
                        note = todaysnote
                    }
                        .multilineTextAlignment(.trailing)
                        .frame(width: screen.width - 90, height: 50)
                    
                }
                Text(note ?? "No notes")
            }
            .padding()
        }
//        .multilineTextAlignment(.center)
        .frame(width: screen.width - 60, height: 180)
        .shadow(radius: 10)
    }
}

struct Card {
    let prompt: String
    let answer: String
    let date = Date()
    static let example = Card(prompt: "Who playe Doctor Who?", answer: "Jodie 78")
    
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
