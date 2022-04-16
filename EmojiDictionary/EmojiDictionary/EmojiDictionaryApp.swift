//
//  EmojiDictionaryApp.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/10/22.
//

import SwiftUI

@main
struct EmojiDictionaryApp: App {
     @StateObject private var vm = HomeViewModel()
     
     var body: some Scene {
         WindowGroup {
             NavigationView{
                 HomeView()
                     .navigationBarHidden(true)
             }
             .environmentObject(vm)
         }
    }
}
