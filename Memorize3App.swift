//
//  Memorize3App.swift
//  Memorize3
//
//  Created by Ariel David Suarez on 12/30/22.
//

import SwiftUI

@main
struct Memorize3App: App {
    let game = EmojiMemoryGame()
    let theme = EmojiMemoryGame.randomTheme
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game, theme: theme)
        }
    }
}
