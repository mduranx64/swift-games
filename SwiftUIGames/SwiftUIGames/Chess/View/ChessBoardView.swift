//
//  ChessBoardView.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 04-09-24.
//

import SwiftUI

enum BoardTheme {
    case black
    case brown
}

struct ChessBoardView: View {
    // Define rows for the 8x8 grid (8 rows)
    let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    let captureRows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    let numbers = ["8", "7", "6", "5", "4", "3", "2", "1"]

    let rotation = 180.0
    
    @ObservedObject var board: Board
    @Environment(\.dismiss) private var dismiss
    @State private var showCustomAlert = false
    @State private var showMenuAlert = false
    @State private var showWinAlert = false
    @State private var showPawnAlert = false
    @State private var orientation = UIDevice.current.orientation
    @State private var theme: BoardTheme = .black
    @State private var promotedPieceType: PieceType = .queen
    
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
                        
                        if orientation == .portrait || orientation == .unknown {
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
                        
                            VStack {
                                Image(systemName: "gamecontroller.fill").foregroundStyle(.black)
                                Text("Black move")
                                    .font(Font.App.chalkboardSERegular.of(size: 14))
                                    .foregroundStyle(.black)
                            }.opacity(board.currentTurn == .black ? 1 : 0)
                        
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
                                            
                                            let image: ImageResource = getBoardImage(isLight: isLight)
                                            
                                            let color = isLight ? Color.black : Color.white
                                            let numberGuide: String = index < numbers.count ? numbers[index] : ""
                                            let letterGuide: String = row == 7 ? letters[column] : ""
                                            
                                            ZStack(alignment: .bottomTrailing) {
                                                ZStack(alignment: .topLeading) {
                                                    Image(image) // Replace with custom image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: squareSize, height: squareSize)
                                                    Text("\(numberGuide)")
                                                        .font(Font.App.chalkboardSERegular.of(size: 14))
                                                        .foregroundStyle(color)
                                                        .padding(EdgeInsets(top: -4, leading: 0, bottom: 0, trailing: 0))
                                                }
                                                Text("\(letterGuide)")
                                                    .font(Font.App.chalkboardSERegular.of(size: 14))
                                                    .foregroundStyle(color)
                                                    .padding(EdgeInsets(top: -4, leading: 0, bottom: 0, trailing: 0))
                                            }
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
                                                        .padding(2)
                                                        .border(board.isSelected(at: position) ? Color.yellow : Color.clear, width: 2)
                                                        .frame(width: squareSize , height: squareSize)
                                                        .onTapGesture {
                                                            board.selectPiece(at: position)
                                                            if board.isBlackKingCaptured || board.isWhiteKingCaptured {
                                                                showWinAlert = true
                                                            }
                                                            if board.isPiecePromoted {
                                                                showPawnAlert = true
                                                            }
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
                        
                            VStack {
                                Image(systemName: "gamecontroller.fill").foregroundStyle(.white)
                                Text("White move")
                                    .font(Font.App.chalkboardSERegular.of(size: 14))
                                    .foregroundStyle(.white)
                            }.opacity(board.currentTurn == .white ? 1 : 0)
                        
                        if orientation == .portrait || orientation == .unknown {
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
                    .navigationBarHidden(orientation == .landscapeLeft || orientation == .landscapeRight)
                }
            }.edgesIgnoringSafeArea(.all)
            
            if showPawnAlert {
                Color.black.opacity(0.4) // Dim background
                    .edgesIgnoringSafeArea(.all)
                let title = board.isWhiteKingCaptured ? "Black pawn promotion!" : "White pawn promotion!"
                VStack(spacing: 16) {
                    Text(title)
                        .font(Font.App.chalkboardSERegular.of(size: 24))
                        .foregroundStyle(.gameText)
                    
                    Text("Game settings")
                        .font(Font.App.chalkboardSERegular.of(size: 18))
                        .foregroundStyle(.gameText)
                    
                    Picker("Select a piece type", selection: $promotedPieceType) {
                        Text("Queen").tag(PieceType.queen)
                            .font(Font.App.chalkboardSERegular.of(size: 18))
                            .foregroundStyle(.gameText)
                        Text("Knight").tag(PieceType.knight)
                            .font(Font.App.chalkboardSERegular.of(size: 18))
                            .foregroundStyle(.gameText)
                        Text("Bishop").tag(PieceType.bishop)
                            .font(Font.App.chalkboardSERegular.of(size: 18))
                            .foregroundStyle(.gameText)
                        Text("Rook").tag(PieceType.rook)
                            .font(Font.App.chalkboardSERegular.of(size: 18))
                            .foregroundStyle(.gameText)
                    }
                    .pickerStyle(.menu)
                    .font(Font.App.chalkboardSERegular.of(size: 18))
                    .foregroundStyle(.gameText)
                    .tint(.gameText)
                    
                    HStack {
                        SGButton(title: "Accept", action: {
                            showPawnAlert = false
                            board.promotePiece(type: promotedPieceType)
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
            
            if showWinAlert {
                Color.black.opacity(0.4) // Dim background
                    .edgesIgnoringSafeArea(.all)
                let title = board.isWhiteKingCaptured ? "Black pieces win!" : "White pieces win!"
                VStack(spacing: 16) {
                    Text(title)
                        .font(Font.App.chalkboardSERegular.of(size: 24))
                        .foregroundStyle(.gameText)
                    
                    let imageName: ImageResource = board.isWhiteKingCaptured ? .bKing : .wKing
                    Image(imageName) // Replace with custom image
                        .resizable()
                        .scaledToFit()
                        .frame(width: squareSize ,height: squareSize)
                    
                    HStack {
                        
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
                    
                        Picker("Board theme", selection: $theme) {
                            Text("Black").tag(BoardTheme.black)
                                .font(Font.App.chalkboardSERegular.of(size: 18))
                                .foregroundStyle(.gameText)
                            Text("Brown").tag(BoardTheme.brown)
                                .font(Font.App.chalkboardSERegular.of(size: 18))
                                .foregroundStyle(.gameText)
                        }
                        .font(Font.App.chalkboardSERegular.of(size: 24))
                        .foregroundStyle(.gameText)
                        .pickerStyle(.segmented)
                    
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
    
    private func getBoardImage(isLight: Bool) -> ImageResource {
        switch theme {
        case .black:
            return isLight ? .squareGrayLight : .squareGrayDark
        case .brown:
            return isLight ? .squareBrownLight : .squareBrownDark
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
        debugPrint(item)
#endif
        return self
    }
}
