//
//  Piece.swift
//  SwiftChess
//
//  Created by Miguel Duran on 14-04-24.
//

import Foundation

public enum PieceType {
    case king
    case queen
    case rook
    case knight
    case bishop
    case pawn
}

public enum PieceColor {
    case white
    case black
}

public class Piece {
    private(set) var type: PieceType
    private(set) var color: PieceColor
    
    public init(_ type: PieceType, color: PieceColor) {
        self.type = type
        self.color = color
    }
}
