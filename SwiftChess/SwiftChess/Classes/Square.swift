//
//  Square.swift
//  SwiftChess
//
//  Created by Miguel Duran on 18-04-24.
//

import Foundation

public enum SquareState {
    case empty
    case piece
}

public class Square {
    private(set) var squareState: SquareState
    private(set) var piece: Piece?
    
    init() {
        self.squareState = .empty
        self.piece = nil
    }
    
    init(piece: Piece) {
        self.squareState = .piece
        self.piece = piece
    }
}
