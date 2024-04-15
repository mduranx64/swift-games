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

public class Piece {
    private(set) var pieceType: PieceType
    
    public init(_ pieceType: PieceType) {
        self.pieceType = pieceType
    }
}
