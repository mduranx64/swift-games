//
//  SwiftUIGamesApp.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 04-09-24.
//

import SwiftUI

@main
struct SwiftUIGamesApp: App {

    var body: some Scene {
        WindowGroup {
            ChessBoardView(board: Board())
        }
    }
}
