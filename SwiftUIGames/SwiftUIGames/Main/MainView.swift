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
    @State private var showInfoAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            
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
                    showInfoAlert = true
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
            
            if showInfoAlert {
                Color.black.opacity(0.4) // Dim background
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    Image(.dev)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    
                    Text("Swift Games")
                        .font(Font.App.chalkboardSERegular.of(size: 24))
                        .foregroundStyle(.gameText)
                    
                    Text("An open source collection of games made in Swift to learn programming and how to play the games")
                        .font(Font.App.chalkboardSERegular.of(size: 18))
                        .foregroundStyle(.gameText)
                        .multilineTextAlignment(.center)
                    URL(string: "https://github.com/mduranx64/swift-games").map({
                        Link("Visit the repository on Github to contribute", destination: $0)
                            .font(Font.App.chalkboardSERegular.of(size: 18))
                            .foregroundStyle(.blue)
                    })
                    
                    Text("Version: \(Bundle.main.appVersionShort) (\(Bundle.main.appVersionLong))")
                                        .font(Font.App.chalkboardSERegular.of(size: 14))
                                        .foregroundStyle(.gameText)
                    HStack {
    
                        SGButton(title: "Accept", action: {
                            showInfoAlert = false // Cancel action
                        })
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(.gameBackground)
                .cornerRadius(10)
                .frame(maxWidth: geometry.size.width * 0.8)
                .transition(.scale) // Add a transition effect
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(1) // Ensure it appears above other views
            }
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
