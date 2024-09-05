//
//  ContentView.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 04-09-24.
//

import SwiftUI

struct ChessBoardView: View {
    // Define rows for the 8x8 grid (8 rows)
    let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() // Pushes the grid to the vertical center
                
                ZStack {
                    let gridSize = geometry.size.width
                    VStack {
                        
                        // Embed LazyHGrid in a square with 32 points padding on each side
                        let gridSize = geometry.size.width - 64 // Total padding: 32 on each side
                        LazyHGrid(rows: rows, spacing: 0) {
                            ForEach(0..<64, id: \.self) { index in
                                // Determine row and column based on the index
                                let row = index % 8
                                let column = index / 8
                                
                                // Alternate color based on row and column
                                let isLight = (row + column) % 2 == 0
                                
                                let image: ImageResource = isLight ? .squareGrayLight : .squareGrayDark
                                Image(image) // Replace with custom image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: (geometry.size.width - 64) / 8, height: (geometry.size.width - 64) / 8).Print((row + column) % 2)
                            }
                        }
                        .frame(width: gridSize, height: gridSize) // Square frame for the grid
                        .padding(32) // 32 points of space on each side
                        
                    }
                    .frame(width: gridSize, height: gridSize)
                    .background(Color.gray) // Add gray background to the VStack
                    .edgesIgnoringSafeArea(.all) // Optional: to make the VStack extend to edges
                }
                
                Spacer() // Pushes the grid to the vertical center
                
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ChessBoardView()
            .edgesIgnoringSafeArea(.all) // Optional: to take up the full screen
    }
}

struct ChessBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func Print(_ item: Any) -> some View {
#if DEBUG
        print(item)
#endif
        return self
    }
}
