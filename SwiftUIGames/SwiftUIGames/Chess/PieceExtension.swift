//
//  PieceExtension.swift
//  SwiftGames
//
//  Created by Miguel Duran on 31-08-24.
//

import Foundation
import UIKit

extension Piece {
    var pieceImage: ImageResource {
        switch color {
        case .white:
            switch type {
            case .bishop:
                return .wBishop
            case .king:
                return .wKing
            case .knight:
                return .wKnight
            case .pawn:
                return .wPawn
            case .queen:
                return .wQueen
            case .rook:
                return .wRook
            }
        case .black:
            switch type {
            case .bishop:
                return .bBishop
            case .king:
                return .bKing
            case .knight:
                return .bKnight
            case .pawn:
                return .bPawn
            case .queen:
                return .bQueen
            case .rook:
                return .bRook
            }
        }
    }
}
