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
        XCTAssertNotNil(makeSUT(.king, color: .white))
        let piece = makeSUT(.king, color: .white)
        XCTAssertEqual(piece.type, PieceType.king)
        XCTAssertEqual(piece.color, PieceColor.white)
    }
    
    private func makeSUT(_ type: PieceType, color: PieceColor) -> Piece {
        let piece = Piece(type, color: color)
        return piece
    }

}
