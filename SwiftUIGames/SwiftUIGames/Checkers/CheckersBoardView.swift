//
//  CheckersBoardView.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 03-03-25.
//

import SwiftUI

struct CheckersBoardView: View {
    let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    @State private var theme: BoardTheme = .black
    @State private var orientation = UIDevice.current.orientation

    var body: some View {
        NavigationView {
            Color.gameBackground.ignoresSafeArea(.all).overlay {
                
                GeometryReader { geometry in
                    let squares: CGFloat = 8.0
                    let gridSize = min(geometry.size.width, geometry.size.height)
                    let squareSize = gridSize / squares
                    
                    DynamicStackOrientation(spacing: 8, orientation: $orientation) {
                        Spacer()
                        
                        VStack(spacing: 0) {
                            ZStack {
                                VStack(spacing: 0) {
                                    
                                    LazyHGrid(rows: rows, spacing: 0) {
                                        ForEach(0..<64, id: \.self) { index in
                                            // Determine row and column based on the index
                                            let row = index % Int(squares)
                                            let column = index / Int(squares)
                                            
                                            // Alternate color based on row and column
                                            let isLight = (row + column) % 2 == 0
                                            
                                            let image: ImageResource = getBoardImage(isLight: isLight)
                                            
                                            Image(image) // Replace with custom image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: squareSize, height: squareSize)
                                        }
                                    }
                                    
                                }
                                .frame(width: gridSize, height: gridSize)
                                
                                //TODO: pieces
                                VStack {
                                    LazyHGrid(rows: rows, spacing: 0) {
                                        ForEach(0..<64, id: \.self) { x in
                                            HStack(spacing: 0) {
                                                ForEach(0..<8, id: \.self) { y in
                                                    
                                                    Circle()
                                                        .foregroundColor(.white)
                                                        .padding(5)
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(width: gridSize, height: gridSize)

                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    private func getBoardImage(isLight: Bool) -> ImageResource {
        switch theme {
        case .black:
            return isLight ? .squareGrayLight : .squareGrayDark
        case .brown:
            return isLight ? .squareBrownLight : .squareBrownDark
        }
    }
}

#Preview {
    CheckersBoardView()
}
