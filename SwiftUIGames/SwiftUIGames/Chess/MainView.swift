//
//  MainView.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 06-09-24.
//

import SwiftUI

enum Game {
    case chess
    case comingSoon
}

struct GameItem: Identifiable {
    let id = UUID()
    let title: String
    let image: Image
    let game: Game
}

struct MainView: View {
    
    // Sample game list
    let gameList: [GameItem] = [
        GameItem(title: "Chess", image: Image(.chessCover), game: .chess),
        GameItem(title: "Coming Soon", image: Image(systemName: "questionmark"), game: .comingSoon),
        GameItem(title: "Coming Soon", image: Image(systemName: "questionmark"), game: .comingSoon),
        GameItem(title: "Coming Soon", image: Image(systemName: "questionmark"), game: .comingSoon),
        GameItem(title: "Coming Soon", image: Image(systemName: "questionmark"), game: .comingSoon),
        GameItem(title: "Coming Soon", image: Image(systemName: "questionmark"), game: .comingSoon)
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.gameBackground
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .font: UIFont(name: "ChalkboardSE-Regular", size: 24)!,
            .foregroundColor: UIColor.gameText,
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "ChalkboardSE-Regular", size: 32)!,
            .foregroundColor: UIColor.gameText,
        ]
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "ChalkboardSE-Regular", size: 16)!,
            .foregroundColor: UIColor.gameText
        ]
        appearance.backButtonAppearance = backButtonAppearance
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(gameList, id: \.id) { item in
                        if let destinationView = navigateToGame(item.game) {
                            NavigationLink(destination: destinationView) {
                                GameView(title: item.title, image: item.image)
                            }
                        } else {
                            GameView(title: item.title, image: item.image)
                        }
                    }
                }
                .padding()
            }
            .background(.gameBackground)
            .navigationTitle("Swift Games")
            .navigationBarItems(trailing: Button(action: {
                showInfo()
            }) {
                Image(systemName: "info.circle")
            })
        }
        .onAppear {
            // Ensure the navigation view is fully ready before making UI updates
            print("MainView appeared")
        }
    }
    
    func navigateToGame(_ game: Game) -> AnyView? {
        // Handle navigation based on the selected game
        switch game {
        case .chess:
            return AnyView(ChessBoardView(board: Board()))
        case .comingSoon:
            return nil
        }
    }
    
    func showInfo() {
        print("Showing info")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
