//
//  ChessBoardView.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 04-09-24.
//

import SwiftUI

struct ChessBoardView: View {
    // Define rows for the 8x8 grid (8 rows)
    let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    let numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
    let rotation = 180.0
    let board = Board()
    
    var body: some View {
        GeometryReader { geometry in
            let padding: CGFloat = 32.0
            let squares: CGFloat = 8
            let totalPadding: CGFloat = 64.0
            let gridSize:CGFloat = geometry.size.width - totalPadding // Total padding: 32 on each side
            
            VStack {
                Spacer()
                // Pushes the grid to the vertical center
                VStack(spacing: 0) {
                    
                    HStack(spacing: 0) {
                        ForEach(letters, id: \.self) { letter in
                            Text(letter)
                                .rotationEffect(.degrees(rotation))
                                .frame(width: gridSize / squares, height: padding)
                        }
                    }
                    
                    HStack(spacing: 0) {

                        VStack(spacing: 0) {
                            ForEach(numbers.reversed(), id: \.self) { number in
                                Text(number).frame(width: padding, height: gridSize / squares)
                            }
                        }
                        
                        ZStack {
                            
                            //Board
                            VStack(spacing: 0) {
                                
                                // Embed LazyHGrid in a square with 32 points padding on each side
                                LazyHGrid(rows: rows, spacing: 0) {
                                    ForEach(0..<64, id: \.self) { index in
                                        // Determine row and column based on the index
                                        let row = index % Int(squares)
                                        let column = index / Int(squares)
                                        
                                        // Alternate color based on row and column
                                        let isLight = (row + column) % 2 == 0
                                        
                                        let image: ImageResource = isLight ? .squareGrayLight : .squareGrayDark
                                        let squareSize = gridSize / squares
                                        Image(image) // Replace with custom image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: squareSize, height: squareSize)
                                    }
                                }
                                
                            }
                            .frame(width: gridSize, height: gridSize)
                            
                            // Pieces
                            VStack(spacing: 0) {
                                
                                // Embed LazyHGrid in a square with 32 points padding on each side
                                // Total padding: 32 on each side
                                LazyHGrid(rows: rows, spacing: 0) {
                                    ForEach(0..<board.pieces.count, id: \.self) { x in
                                        
                                        let row = board.pieces[x]
                                        
                                        HStack(spacing: 0) {
                                            ForEach(0..<row.count, id: \.self) { y in
                                                let pieceImage = row[y]?.pieceImage ?? .empty
                                                let squareSize = gridSize / squares
                                                Image(pieceImage) // Replace with custom image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: squareSize , height: squareSize).onTapGesture {
                                                        
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: gridSize, height: gridSize)
                        }
                        
                        VStack(spacing:0) {
                            ForEach(numbers.reversed(), id: \.self) { number in
                                Text(number)
                                    .frame(width: padding, height: gridSize / squares).rotationEffect(.degrees(rotation))                            }
                        }
                    }
                    
                    HStack(spacing: 0) {
                        ForEach(letters, id: \.self) { letter in
                            Text(letter)
                                .frame(width: gridSize / squares, height: padding)
                        }
                    }
                    
                }.frame(width: geometry.size.width, height: geometry.size.width).background(.gray)
                    .edgesIgnoringSafeArea(.all)
                
                Spacer() // Pushes the grid to the vertical center
                
            }.background(.cyan)
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
