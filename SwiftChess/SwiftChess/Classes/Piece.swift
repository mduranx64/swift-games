//
//  Piece.swift
//  SwiftChess
//
//  Created by Miguel Duran on 14-04-24.
//

import Foundation

public struct Position {
    let x: Int
    let y: Int
}


public enum PieceType: String {
    case king
    case queen
    case rook
    case knight
    case bishop
    case pawn
}

public enum PieceColor: String {
    case white
    case black
}

public class Piece {
    private(set) var type: PieceType
    private(set) var color: PieceColor
    var isFirstMove = true
    var position: Position = Position(x: 0, y: 0)
    
    public init(_ type: PieceType, color: PieceColor) {
        self.type = type
        self.color = color
    }
}
