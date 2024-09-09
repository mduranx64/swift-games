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
    let captureRows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    let numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
    let rotation = 180.0
    
    @ObservedObject var board: Board
    @Environment(\.dismiss) private var dismiss
    @State private var showCustomAlert = false
    @State private var showMenuAlert = false
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        
        GeometryReader { geometry in
            let squares: CGFloat = 8.0
            let gridSize = min(geometry.size.width, geometry.size.height)
            let squareSize = gridSize / squares
            NavigationView {
                Color.gameBackground.ignoresSafeArea(.all).overlay {
                    
                    DynamicStack(spacing: 8) {
                        Spacer()
                        
                        let captureSize = board.blackCapture.count > 8 || board.whiteCapture.count > 8 ? squareSize * 2 : squareSize
                        
                        if orientation == .portrait {
                            LazyVGrid(columns: captureRows, spacing: 0) {
                                ForEach(0..<board.whiteCapture.count, id: \.self) { index in
                                    let pieceImage = board.whiteCapture[index].pieceImage
                                    Image(pieceImage) // Replace with custom image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: squareSize, height: squareSize)
                                }
                            }.frame(width: gridSize, height: captureSize)
                        } else {
                            LazyHGrid(rows: captureRows, spacing: 0) {
                                ForEach(0..<board.whiteCapture.count, id: \.self) { index in
                                    let pieceImage = board.whiteCapture[index].pieceImage
                                    Image(pieceImage) // Replace with custom image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: squareSize, height: squareSize)
                                }
                            }.frame(width: captureSize, height: gridSize)
                        }
                        
                        
                        // Pushes the grid to the vertical center
                        VStack(spacing: 0) {
                            
                            
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
                            
                        }.frame(width: gridSize, height: gridSize)
                            .background(.gray)
                            .edgesIgnoringSafeArea(.all)
                        
                        if orientation == .portrait {
                            LazyVGrid(columns: captureRows, spacing: 0) {
                                ForEach(0..<board.blackCapture.count, id: \.self) { index in
                                    let pieceImage = board.blackCapture[index].pieceImage
                                    Image(pieceImage) // Replace with custom image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: squareSize ,height: squareSize)
                                    
                                }
                            }.frame(width: gridSize, height: captureSize)
                        } else {
                            LazyHGrid(rows: captureRows, spacing: 0) {
                                ForEach(0..<board.blackCapture.count, id: \.self) { index in
                                    let pieceImage = board.blackCapture[index].pieceImage
                                    Image(pieceImage) // Replace with custom image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: squareSize ,height: squareSize)
                                    
                                }
                            }.frame(width: captureSize, height: gridSize)
                        }
                        
                        Spacer() // Pushes the grid to the vertical center
                        
                    }
                    .navigationBarTitle("Chess", displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        showMenuAlert = true
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
                    .detectOrientation($orientation)
                    .navigationBarHidden(orientation != .portrait)
                }
            }
            
            if showCustomAlert {
                Color.black.opacity(0.4) // Dim background
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    Text("Confirm Exit")
                        .font(Font.App.chalkboardSERegular.of(size: 24))
                        .foregroundStyle(.gameText)
                    
                    Text("Are you sure you want to exit the game?")
                        .font(Font.App.chalkboardSERegular.of(size: 18))
                        .foregroundStyle(.gameText)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        
                        SGButton(title: "Cancel", action: {
                            showCustomAlert = false
                        })
                        .padding()
                        
                        SGButton(title: "Accept", action: {
                            dismiss()
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
            
            if showMenuAlert {
                Color.black.opacity(0.4) // Dim background
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    
                    Text("Game settings")
                        .font(Font.App.chalkboardSERegular.of(size: 24))
                        .foregroundStyle(.gameText)
                    
                    HStack {
                        
                        SGButton(title: "Accept", action: {
                            showMenuAlert = false
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
