//
//  Board.swift
//  SwiftChess
//
//  Created by Miguel Duran on 18-04-24.
//

import Foundation

public class Board {
    
    private(set) var whiteCapture = [Piece]()
    private(set) var blackCapture = [Piece]()
    var currentTurn: PieceColor = .white
    var inPassingPiece: Piece?
    
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
    
    init(pieces: [[Piece?]]) {
        self.pieces = pieces
    }
    
    private func changeTurn(color: PieceColor) {
        if inPassingPiece != nil, inPassingPiece?.color != color {
            inPassingPiece = nil
        }
        self.currentTurn = color == PieceColor.white ? PieceColor.black : PieceColor.white
    }
    
    func getPieceByPosition(_ position: Position) -> Piece? {
        return pieces[position.x][position.y]
    }
    
    public func movePiece(from: Position, to: Position) -> Bool {
        guard let piece = getPieceByPosition(from), piece.color == currentTurn else {
            return false
        }
        let destiny = getPieceByPosition(to)
        var isMoved = false
        switch piece.type {
        case .pawn:
            switch piece.color {
            case .white, .black:
                if destiny == nil && from.y == to.y { // move
                    let oneStep = piece.color == .white ? 1 : -1
                    let twoStep = piece.color == .white ? 2 : -2
                    let xStep = from.x - to.x
                    
                    if xStep == oneStep { // one step
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                    } else if xStep == twoStep && piece.isFirstMove { // two steps
                        piece.isFirstMove = false
                        move(piece, from: from, to: to)
                        isMoved = true
                        inPassingPiece = piece
                    }
                } else if (destiny != nil && destiny?.color != piece.color) || inPassingPiece != nil { // capture
                    let xStep = from.x - to.x
                    let yStep = from.y - to.y
                    
                    if piece.color == .white {
                        if xStep == 1 && yStep == 1 { // left up
                            if destiny != nil { // capture
                                piece.isFirstMove = false
                                move(piece, from: from, to: to)
                                isMoved = true
                            } else if inPassingPiece != nil { // in passing capture
                                let xPass = from.x
                                let yPass = from.y - 1
                                let tempPass = getPieceByPosition(Position(x: xPass, y: yPass))
                                if tempPass === inPassingPiece {
                                    move(piece, from: from, to: to)
                                    isMoved = true
                                    tempPass.map({ blackCapture.append($0) })
                                    pieces[xPass][yPass] = nil
                                    inPassingPiece = nil
                                }
                            }
                        } else if xStep == 1 && yStep == -1 { // right up
                            if destiny != nil { // capture
                                piece.isFirstMove = false
                                move(piece, from: from, to: to)
                                isMoved = true
                            } else if inPassingPiece != nil { // in passing capture
                                let xPass = from.x
                                let yPass = from.y + 1
                                let tempPass = getPieceByPosition(Position(x: xPass, y: yPass))
                                if tempPass === inPassingPiece {
                                    move(piece, from: from, to: to)
                                    isMoved = true
                                    tempPass.map({ blackCapture.append($0) })
                                    pieces[xPass][yPass] = nil
                                    inPassingPiece = nil
                                }
                            }
                        }
                    } else {
                        if xStep == -1 && yStep == 1 { // left down
                            if destiny != nil { // capture
                                piece.isFirstMove = false
                                move(piece, from: from, to: to)
                                isMoved = true
                            } else if inPassingPiece != nil { // in passing capture
                                let xPass = from.x
                                let yPass = from.y - 1
                                let tempPass = getPieceByPosition(Position(x: xPass, y: yPass))
                                if tempPass === inPassingPiece {
                                    move(piece, from: from, to: to)
                                    isMoved = true
                                    tempPass.map({ blackCapture.append($0) })
                                    pieces[xPass][yPass] = nil
                                    inPassingPiece = nil
                                }
                            }
                        } else if xStep == -1 && yStep == -1 { // right down
                            if destiny != nil { // capture
                                piece.isFirstMove = false
                                move(piece, from: from, to: to)
                                isMoved = true
                            } else if inPassingPiece != nil { // in passing capture
                                let xPass = from.x
                                let yPass = from.y + 1
                                let tempPass = getPieceByPosition(Position(x: xPass, y: yPass))
                                if tempPass === inPassingPiece {
                                    move(piece, from: from, to: to)
                                    isMoved = true
                                    tempPass.map({ blackCapture.append($0) })
                                    pieces[xPass][yPass] = nil
                                    inPassingPiece = nil
                                }
                            }
                        }
                    }
                }
            }
        case .queen:
            switch piece.color {
            case .white, .black:
                if destiny == nil || destiny?.color != piece.color { // move or capture
                    var canMove = true
                    var count = 0
                    let xStep = from.x - to.x
                    let yStep = from.y - to.y
                    if xStep == 0 && yStep > 0 { // left
                        count = from.y - 1
                        while count > to.y {
                            if getPieceByPosition(Position(x: from.x, y: count)) != nil {
                                canMove = false
                            }
                            count -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep == 0 && yStep < 0 { // right
                        count = from.y + 1
                        while count < to.y {
                            if getPieceByPosition(Position(x: from.x, y: count)) != nil {
                                canMove = false
                            }
                            count += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep > 0 && yStep == 0 { // up
                        count = from.x - 1
                        while count > to.x {
                            if getPieceByPosition(Position(x: count, y: from.y)) != nil {
                                canMove = false
                            }
                            count -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep < 0 && yStep == 0 { // down
                        count = from.x + 1
                        while count < to.x {
                            if getPieceByPosition(Position(x: count, y: from.y)) != nil {
                                canMove = false
                            }
                            count += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep > 0 && yStep > 0 { // left up
                        var xCount = from.x - 1
                        var yCount = from.y - 1
                        while xCount > to.x && yCount > to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount -= 1
                            yCount -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep > 0 && yStep < 0 { // right up
                        var xCount = from.x - 1
                        var yCount = from.y + 1
                        while xCount > to.x && yCount < to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount -= 1
                            yCount += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep < 0 && yStep > 0 { // left down
                        var xCount = from.x + 1
                        var yCount = from.y - 1
                        while xCount < to.x && yCount > to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount += 1
                            yCount -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep < 0 && yStep < 0 { // right down
                        var xCount = from.x + 1
                        var yCount = from.y + 1
                        while xCount < to.x && yCount < to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount += 1
                            yCount += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    }
                }
            }
        case .bishop:
            switch piece.color {
            case .white, .black:
                if destiny == nil || destiny?.color != piece.color { // move or capture
                    var canMove = true
                    let xStep = from.x - to.x
                    let yStep = from.y - to.y
                    if xStep > 0 && yStep > 0 { // left up
                        var xCount = from.x - 1
                        var yCount = from.y - 1
                        while xCount > to.x && yCount > to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount -= 1
                            yCount -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep > 0 && yStep < 0 { // right up
                        var xCount = from.x - 1
                        var yCount = from.y + 1
                        while xCount > to.x && yCount < to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount -= 1
                            yCount += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep < 0 && yStep > 0 { // left down
                        var xCount = from.x + 1
                        var yCount = from.y - 1
                        while xCount < to.x && yCount > to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount += 1
                            yCount -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep < 0 && yStep < 0 { // right down
                        var xCount = from.x + 1
                        var yCount = from.y + 1
                        while xCount < to.x && yCount < to.y {
                            if getPieceByPosition(Position(x: xCount, y: yCount)) != nil {
                                canMove = false
                            }
                            xCount += 1
                            yCount += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    }
                }
            }
        case .knight:
            switch piece.color {
            case .white, .black:
                if destiny == nil || destiny?.color != piece.color { // move or capture
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
            case .white, .black:
                if destiny == nil || destiny?.color != piece.color { // move or capture
                    var canMove = true
                    var count = 0
                    let xStep = from.x - to.x
                    let yStep = from.y - to.y
                    
                    if xStep == 0 && yStep > 0 { // left
                        count = from.y - 1
                        while count > to.y {
                            if getPieceByPosition(Position(x: from.x, y: count)) != nil {
                                canMove = false
                            }
                            count -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep == 0 && yStep < 0 { // right
                        count = from.y + 1
                        while count < to.y {
                            if getPieceByPosition(Position(x: from.x, y: count)) != nil {
                                canMove = false
                            }
                            count += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep > 0 && yStep == 0 { // up
                        count = from.x - 1
                        while count > to.x {
                            if getPieceByPosition(Position(x: count, y: from.y)) != nil {
                                canMove = false
                            }
                            count -= 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    } else if xStep < 0 && yStep == 0 { // down
                        count = from.x + 1
                        while count < to.x {
                            if getPieceByPosition(Position(x: count, y: from.y)) != nil {
                                canMove = false
                            }
                            count += 1
                        }
                        if canMove {
                            move(piece, from: from, to: to)
                            isMoved = true
                        }
                    }
                }
            }
        case .king:
            switch piece.color {
            case .white, .black:
                if destiny == nil || destiny?.color != piece.color { // move or capture
                    let xStep = abs(from.x - to.x)
                    let yStep = abs(from.y - to.y)
                    if xStep == 1 && yStep == 1 ||
                        xStep == 0 && yStep == 1 ||
                        xStep == 1 && yStep == 0 {
                        move(piece, from: from, to: to)
                        isMoved = true
                    }
                }
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
        if isMoved {
            changeTurn(color: piece.color)
        }
        return isMoved
    }
    
    private func move(_ fromPiece: Piece, from: Position, to: Position) {
        let destiny = getPieceByPosition(to)
        if destiny == nil {
            pieces[to.x][to.y] = fromPiece
            pieces[from.x][from.y] = nil
        } else {
            if destiny?.color == .white {
                destiny.map({ whiteCapture.append($0) })
            } else {
                destiny.map({ blackCapture.append($0) })
            }
            pieces[to.x][to.y] = fromPiece
            pieces[from.x][from.y] = nil
        }
    }
}
