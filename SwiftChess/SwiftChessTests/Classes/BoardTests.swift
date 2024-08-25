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
        let piece = board?.selectPieceAt(position: Position(x: 6, y: 0))
        checkPiece(piece, type: .pawn, color: .white)
        XCTAssertEqual(piece?.position.x, 6)
        XCTAssertEqual(piece?.position.y, 0)
        let pieceNil = board?.selectPieceAt(position: Position(x: 5, y: 0))
        XCTAssertNil(pieceNil)
    }
    
    func testMovePieceIsNil() {
        let board = makeSUT()
        let isMoved = board?.movePiece(nil, to: Position(x: 5, y: 0))
        XCTAssertFalse(isMoved ?? true)
    }
    
    func testMoveWhitePawnOne() {
        let board = makeSUT()
        let piece = board?.selectPieceAt(position: Position(x: 6, y: 0))
        let isMoved = board?.movePiece(piece, to: Position(x: 5, y: 0))
        XCTAssertTrue(isMoved ?? false)
        let pieceNil = board?.selectPieceAt(position: Position(x: 6, y: 0))
        XCTAssertNil(pieceNil)
        let pieceMoved = board?.selectPieceAt(position: Position(x: 5, y: 0))
        XCTAssertIdentical(piece, pieceMoved)
    }
    
    func testMoveWhitePawnTwo() {
        let board = makeSUT()
        let piece = board?.selectPieceAt(position: Position(x: 6, y: 0))
        let isMoved = board?.movePiece(piece, to: Position(x: 4, y: 0))
        XCTAssertTrue(isMoved ?? false)
        let pieceNil = board?.selectPieceAt(position: Position(x: 6, y: 0))
        XCTAssertNil(pieceNil)
        let pieceMoved = board?.selectPieceAt(position: Position(x: 4, y: 0))
        XCTAssertIdentical(piece, pieceMoved)
    }


    private func makeSUT() -> Board! {
        return Board()
    }
    
    private func checkPiece(_ piece: Piece?, type: PieceType, color: PieceColor) {
        XCTAssertEqual(piece?.type, type)
        XCTAssertEqual(piece?.color, color)
    }
}
