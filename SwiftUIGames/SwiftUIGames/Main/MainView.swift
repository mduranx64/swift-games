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
    
    @State private var selectedGame: Game = .chess
    @State private var isModalPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(gameList, id: \.id) { item in
                        GameView(title: item.title, image: item.image)
                            .onTapGesture {
                                selectedGame = item.game
                                if selectedGame != .comingSoon {
                                    isModalPresented = true
                                }
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
            .fullScreenCover(isPresented: $isModalPresented) {
                navigateToGame(selectedGame)
            }
        }
        .onAppear {
            // Ensure the navigation view is fully ready before making UI updates
            debugPrint("MainView appeared")
        }
    }
    
    func navigateToGame(_ game: Game) -> AnyView {
        // Handle navigation based on the selected game
        switch game {
        case .chess:
            return AnyView(ChessBoardView(board: Board()))
        case .comingSoon:
            return AnyView(EmptyView())
        }
    }
    
    func showInfo() {
        debugPrint("Showing info")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
