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
        XCTAssertEqual(makeSUT()?.pieces.count, 8)
        XCTAssertEqual(makeSUT()?.pieces[0].count, 8)
        XCTAssertEqual(makeSUT()?.pieces[1].count, 8)
        XCTAssertEqual(makeSUT()?.pieces[2].count, 8)
        XCTAssertEqual(makeSUT()?.pieces[3].count, 8)
        XCTAssertEqual(makeSUT()?.pieces[4].count, 8)
        XCTAssertEqual(makeSUT()?.pieces[5].count, 8)
        XCTAssertEqual(makeSUT()?.pieces[6].count, 8)
        XCTAssertEqual(makeSUT()?.pieces[7].count, 8)
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


    private func makeSUT() -> Board! {
        return Board()
    }
}
