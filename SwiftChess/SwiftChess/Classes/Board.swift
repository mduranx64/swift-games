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
        [Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty)],
        [Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty)],
        [Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty)],
        [Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty), Piece(.empty, color: .empty)],
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
    
    func getPieceBy(_ position: Position) -> Piece? {
        return pieces[position.x][position.y]
    }
    
    public func movePiece(from: Position, to: Position) -> Bool {
        guard let piece = getPieceBy(from), piece.type != .empty else {
            return false
        }
        var isMoved = false
        let from = piece.position
        switch piece.type {
        case .pawn:
            switch piece.color {
            case .white:
                if getPieceBy(to)?.type == .empty && from.y == to.y {
                    let xStep = from.x - to.x
                    if xStep == 1 {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    } else if xStep == 2 && piece.isFirstMove == true {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    }
                }
            case .black:
                if getPieceBy(to)?.type == .empty && from.y == to.y {
                    let xStep = from.x - to.x
                    if xStep == -1 {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    } else if xStep == -2 && piece.isFirstMove == true {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    }
                }
            case .empty:
                break
            }
        case .queen:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            case .empty:
                break
            }
        case .bishop:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            case .empty:
                break
            }
        case .knight:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            case .empty:
                break
            }
        case .rook:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            case .empty:
                break
            }
        case .king:
            switch piece.color {
            case .white:
                break
            case .black:
                break
            case .empty:
                break
            }
        case .empty:
            break
        }
        #if DEBUG
        if isMoved {
            for row in pieces {
                var rowText = ""
                for piece in row {
                    rowText += "\(piece?.symbol ?? "") "
                }
                debugPrint(rowText)
            }
        }
        #endif
        return isMoved
    }
    
    private func move(_ fromPiece: Piece, from: Position, to: Position) {
        let toPiece = pieces[to.x][to.y]
        toPiece?.position = from
        fromPiece.position = to
        pieces[from.x][from.y] = toPiece
        pieces[to.x][to.y] = fromPiece
    }
}
