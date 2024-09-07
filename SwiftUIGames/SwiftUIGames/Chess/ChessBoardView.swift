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
    
    @ObservedObject var board: Board
    @Environment(\.dismiss) private var dismiss
    @State private var showCustomAlert = false
    
    
    var body: some View {
        GeometryReader { geometry in
            let padding: CGFloat = 32.0
            let squares: CGFloat = 8.0
            let totalPadding: CGFloat = 2.0 * padding
            let gridSize: CGFloat = geometry.size.width - totalPadding
            
            NavigationView {
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
                                    LazyHGrid(rows: rows, spacing: 0) {
                                        ForEach(0..<board.pieces.count, id: \.self) { x in
                                            
                                            let row = board.pieces[x]
                                            
                                            HStack(spacing: 0) {
                                                ForEach(0..<row.count, id: \.self) { y in
                                                    let pieceImage = row[y]?.pieceImage ?? .empty
                                                    let squareSize = gridSize / squares
                                                    let position = Position(x: x, y: y)
                                                    Image(pieceImage) // Replace with custom image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .border(board.isSelected(at: position) ? Color.yellow : Color.clear, width: 2)
                                                        .frame(width: squareSize , height: squareSize)
                                                        .onTapGesture {
                                                            board.selectPiece(at: position)
                                                            
                                                            
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
                    
                }.background(.gameBackground)
                    .navigationBarTitle("Chess", displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        // show game menu
                    }) {
                        Image(systemName: "gamecontroller")
                    })
                    .navigationBarItems(leading: Button(action: {
                        showCustomAlert = true
                    }) {
                        Image(systemName: "xmark.circle")
                    }).onAppear{
                        debugPrint("ChessBoardView appeared")
                    }
            }
            
            if showCustomAlert {
                Color.black.opacity(0.4) // Dim background
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    Text("Confirm Exit")
                        .font(Font.App.chalkboardSERegular.of(size: 24))
                        .foregroundColor(.gameText)
                    
                    Text("Are you sure you want to exit the game?")
                        .font(Font.App.chalkboardSERegular.of(size: 18))
                        .foregroundColor(.gameText)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        
                        Button(action: {
                            showCustomAlert = false // Cancel action
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .font(Font.App.chalkboardSERegular.of(size: 16))
                                .foregroundColor(.gameText)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            dismiss() // Dismiss ChessBoardView
                        }) {
                            Text("Accept")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.gameRed)
                                .font(Font.App.chalkboardSERegular.of(size: 16))
                                .cornerRadius(10)
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(.gameBackground)
                .cornerRadius(12)
                .frame(maxWidth: geometry.size.width * 0.8)
                .transition(.scale) // Add a transition effect
                .zIndex(1) // Ensure it appears above other views
            }
        }
    }
    
    func showMenu() {
        
    }
}

struct ChessBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ChessBoardView(board: Board())
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
