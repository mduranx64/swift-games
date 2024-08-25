//
//  Board.swift
//  SwiftChess
//
//  Created by Miguel Duran on 18-04-24.
//

import Foundation

public class Board {
    
    private(set) var selectedPiece: Piece?
    
    private(set) var pieces: [[Piece?]] = [
        [Piece(.rook, color: .black), Piece(.knight, color: .black), Piece(.bishop, color: .black), Piece(.queen, color: .black),
         Piece(.king, color: .black), Piece(.bishop, color: .black), Piece(.knight, color: .black), Piece(.rook, color: .black)],
        [Piece(.pawn, color: .black), Piece(.pawn, color: .black), Piece(.pawn, color: .black), Piece(.pawn, color: .black),
         Piece(.pawn, color: .black), Piece(.pawn, color: .black), Piece(.pawn, color: .black), Piece(.pawn, color: .black)],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [Piece(.pawn, color: .white), Piece(.pawn, color: .white), Piece(.pawn, color: .white), Piece(.pawn, color: .white),
         Piece(.pawn, color: .white), Piece(.pawn, color: .white), Piece(.pawn, color: .white), Piece(.pawn, color: .white)],
        [Piece(.rook, color: .white), Piece(.knight, color: .white), Piece(.bishop, color: .white), Piece(.queen, color: .white),
         Piece(.king, color: .white), Piece(.bishop, color: .white), Piece(.knight, color: .white), Piece(.rook, color: .white)]
    ]
    
    init() {
        setPiecesPosition()
    }
    
    private func setPiecesPosition() {
        for (i, row) in pieces.enumerated() {
            for (j, piece) in row.enumerated() {
                piece?.position = Position(x: i, y: j)
            }
        }
    }
    
    private func getPieceBy(_ position: Position) -> Piece? {
        return pieces[position.x][position.y]
    }
    
    public func movePiece(_ piece: Piece?, to: Position) -> Bool {
        guard let piece = piece else {
            return false
        }
        var isMoved = false
        let from = piece.position
        switch piece.type {
        case .pawn:
            switch piece.color {
            case .white:
                if getPieceBy(to) == nil && from.y == to.y {
                    let xMinus = from.x - to.x
                    if xMinus == 1 {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    } else if xMinus == 2 && piece.isFirstMove == true {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    }
                }
            case .black:
                break
            }
        case .queen:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            }
        case .bishop:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            }
        case .knight:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            }
        case .rook:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            }
        case .king:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            }
        }
        
        return isMoved
    }
    
    private func move(_ piece: Piece, from: Position, to: Position) {
        pieces[to.x][to.y] = piece
        pieces[from.x][from.y] = nil
        piece.position = to
    }
    
    public func selectPieceAt(position: Position) -> Piece? {
        self.selectedPiece = getPieceBy(position)
        return selectedPiece
    }
}
