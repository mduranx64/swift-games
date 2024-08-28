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
        
    }
    
    func getPieceByPosition(_ position: Position) -> Piece? {
        return pieces[position.x][position.y]
    }
    
    public func movePiece(from: Position, to: Position) -> Bool {
        guard let piece = getPieceByPosition(from) else {
            return false
        }
        let destiny = getPieceByPosition(to)
        var isMoved = false
        switch piece.type {
        case .pawn:
            switch piece.color {
            case .white, .black:
                let oneStep = piece.color == .white ? 1 : -1
                let twoStep = piece.color == .white ? 2 : -2
                if destiny == nil && from.y == to.y {
                    let xStep = from.x - to.x
                    if xStep == oneStep {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    } else if xStep == twoStep && piece.isFirstMove == true {
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    }
                }
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
            case .white, .black:
                if destiny == nil || destiny?.color != piece.color {
                    let xStep = abs(from.x - to.x)
                    let yStep = abs(from.y - to.y)
                    if xStep == 1 && yStep == 2 || xStep == 2 && yStep == 1 {
                        move(piece, from: from, to: to)
                        isMoved = true
                    }
                }
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
        #if DEBUG
        if isMoved {
            for row in pieces {
                var rowText = ""
                for piece in row {
                    rowText += "\(piece?.symbol ?? "ˣ") "
                }
                debugPrint(rowText)
            }
        }
        #endif
        return isMoved
    }
    
    private func move(_ fromPiece: Piece, from: Position, to: Position) {
        pieces[to.x][to.y] = fromPiece
        pieces[from.x][from.y] = nil
    }
}
