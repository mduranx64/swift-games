//
//  Piece.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 05-09-24.
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
    
    public init(_ type: PieceType, color: PieceColor) {
        self.type = type
        self.color = color
    }
    
    func update(type: PieceType, color: PieceColor) {
        self.type = type
        self.color = color
    }
    
    var symbol: String {
        switch color {
        case .white:
            switch type {
            case .king:
                return "♚"
            case .queen:
                return "♛"
            case .rook:
                return "♜"
            case .knight:
                return "♞"
            case .bishop:
                return "♝"
            case .pawn:
                return "♟"
            }
        case .black:
            switch type {
            case .king:
                return "♔"
            case .queen:
                return "♕"
            case .rook:
                return "♖"
            case .knight:
                return "♘"
            case .bishop:
                return "♗"
            case .pawn:
                return "♙"
            }
        }
    }
}
