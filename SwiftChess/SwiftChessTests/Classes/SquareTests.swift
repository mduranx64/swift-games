//
//  SquareTests.swift
//  SwiftChessTests
//
//  Created by Miguel Duran on 18-04-24.
//

import XCTest
@testable import SwiftChess

final class SquareTests: XCTestCase {

    func testSquareInitEmpty() {
        XCTAssertNotNil(makeSUT())
        XCTAssertEqual(makeSUT()?.squareState, SquareState.empty)
    }
    
    func testSquareInitWithPiece() {
        XCTAssertEqual(makeSUT(Piece(.king))?.squareState, SquareState.piece)
        XCTAssertEqual(makeSUT(Piece(.king))?.piece?.pieceType, PieceType.king)
    }
    
    private func makeSUT(_ piece: Piece? = nil) -> Square? {
        if let piece = piece {
            return Square(piece: piece)
        } else {
            return Square()
        }
    }
}
