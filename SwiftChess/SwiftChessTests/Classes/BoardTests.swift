//
//  BoardTests.swift
//  SwiftChessTests
//
//  Created by Miguel Duran on 18-04-24.
//

import XCTest
@testable import SwiftChess

final class BoardTests: XCTestCase {
    
    func testBoardInit() {
        XCTAssertNotNil(makeSUT())
    }
    
    func testBoardPiecesCount() {
        XCTAssertEqual(makeSUT().pieces.count, 8)
        XCTAssertEqual(makeSUT().pieces[0].count, 8)
        XCTAssertEqual(makeSUT().pieces[1].count, 8)
        XCTAssertEqual(makeSUT().pieces[2].count, 8)
        XCTAssertEqual(makeSUT().pieces[3].count, 8)
        XCTAssertEqual(makeSUT().pieces[4].count, 8)
        XCTAssertEqual(makeSUT().pieces[5].count, 8)
        XCTAssertEqual(makeSUT().pieces[6].count, 8)
        XCTAssertEqual(makeSUT().pieces[7].count, 8)
    }
    
    func testBoardPiecesPositionsAndColors() {
        let pieces: [[PieceType?]] = [
            [.rook, .knight, .bishop, .queen, .king, .bishop, .knight, .rook],
            [.pawn, .pawn, .pawn, .pawn, .pawn, .pawn, .pawn, .pawn],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [.pawn, .pawn, .pawn, .pawn, .pawn, .pawn, .pawn, .pawn],
            [.rook, .knight, .bishop, .queen, .king, .bishop, .knight, .rook]
            
        ]
        
        let colors: [[PieceColor?]] = [
            [.black, .black, .black, .black, .black, .black, .black, .black],
            [.black, .black, .black, .black, .black, .black, .black, .black],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [.white, .white, .white, .white, .white, .white, .white, .white],
            [.white, .white, .white, .white, .white, .white, .white, .white]
            
        ]
        let boardPieces = makeSUT().pieces
        for (i, row) in boardPieces.enumerated() {
            for (j, item) in row.enumerated() {
                XCTAssertEqual(item?.type, pieces[i][j], "\(i) \(j)")
                XCTAssertEqual(item?.color, colors[i][j], "\(i) \(j)")
            }
        }
    }
    
    func testBoardPiecesPositions() {
        let pieces = makeSUT().pieces
        checkPiece(pieces[0][0], type: .rook, color: .black)
        checkPiece(pieces[0][7], type: .rook, color: .black)
    }
    
    func testSelectPiece() {
        let board = makeSUT()
        let piece = board?.getPieceByPosition(Position(x: 6, y: 0))
        checkPiece(piece, type: .pawn, color: .white)
        let pieceEmpty = board?.getPieceByPosition(Position(x: 5, y: 0))
        XCTAssertNil(pieceEmpty?.type)
    }
    
    func testMovePieceEmpty() {
        let board = makeSUT()
        let isMoved = board?.movePiece(from: Position(x: 5, y: 0), to: Position(x: 5, y: 0))
        XCTAssertFalse(isMoved ?? true)
    }
    
    func testMoveWhitePawnOne() {
        let from = Position(x: 6, y: 0)
        let to = Position(x: 5, y: 0)
        checkPieceMove(from: from, to: to, type: .pawn, color: .white)

    }
    
    func testMoveWhitePawnTwo() {
        let from = Position(x: 6, y: 0)
        let to = Position(x: 4, y: 0)
        checkPieceMove(from: from, to: to, type: .pawn, color: .white)
    }
    
    func testMoveBlackPawnOne() {
        let from = Position(x: 1, y: 1)
        let to = Position(x: 2, y: 1)
        checkPieceMove(from: from, to: to, type: .pawn, color: .black)

    }
    
    func testMoveBlackPawnTwo() {
        let from = Position(x: 1, y: 1)
        let to = Position(x: 3, y: 1)
        checkPieceMove(from: from, to: to, type: .pawn, color: .black)
    }
    
    func testMoveWhiteKnight() {
        let from = Position(x: 7, y: 1)
        let to = Position(x: 5, y: 2)
        checkPieceMove(from: from, to: to, type: .knight, color: .white)
    }
    
    func testMoveBlackKnight() {
        let from = Position(x: 0, y: 1)
        let to = Position(x: 2, y: 0)
        checkPieceMove(from: from, to: to, type: .knight, color: .black)
    }


    private func makeSUT() -> Board! {
        return Board()
    }
    
    private func checkPiece(_ piece: Piece?, type: PieceType, color: PieceColor) {
        XCTAssertEqual(piece?.type, type)
        XCTAssertEqual(piece?.color, color)
    }
    
    private func checkPieceMove(from: Position, to: Position, type: PieceType, color: PieceColor) {
        let board = makeSUT()
        let isMoved = board?.movePiece(from: from, to: to)
        let origin = board?.getPieceByPosition(from)
        let destiny = board?.getPieceByPosition(to)
        XCTAssertTrue(isMoved ?? false)
        XCTAssertEqual(origin?.type, nil)
        XCTAssertEqual(origin?.color, nil)
        XCTAssertEqual(destiny?.type, type)
        XCTAssertEqual(destiny?.color, color)
    }
}
