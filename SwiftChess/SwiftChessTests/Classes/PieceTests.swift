//
//  PieceTests.swift
//  SwiftChessTests
//
//  Created by Miguel Duran on 14-04-24.
//
import XCTest
@testable import SwiftChess

final class PieceTests: XCTestCase {

    func testPieceInit() {
        XCTAssertNotNil(makeSUT(.king))
        let piece = makeSUT(.king)
        XCTAssertEqual(piece.pieceType, PieceType.king)
    }
    
    private func makeSUT(_ type: PieceType) -> Piece {
        let piece = Piece(type)
        return piece
    }

}
