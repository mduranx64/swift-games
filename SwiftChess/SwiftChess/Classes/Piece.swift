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
    case empty
}

public enum PieceColor: String {
    case white
    case black
    case empty
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
    
    var imageName: String? {
        var name: String? = nil
        var colorLetter: String {
            switch color {
            case .white:
                return "w"
            case .black:
                return "b"
            default:
                return ""
            }
        }
        
        switch type {
        case .empty:
            break
        default:
            name = "\(colorLetter)_\(type.rawValue)"
        }
        return name
    }
}
