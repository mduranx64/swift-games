//
//  PieceTests.swift
//  SwiftGamesTests
//
//  Created by Miguel Duran on 14-04-24.
//
import XCTest
@testable import SwiftGames

final class PieceTests: XCTestCase {

    func testPieceInit() {
        XCTAssertNotNil(makeSUT(.king, color: .white))
        let piece = makeSUT(.king, color: .white)
        XCTAssertEqual(piece.type, PieceType.king)
        XCTAssertEqual(piece.color, PieceColor.white)
    }
    
    func testPieceUpdate() {
        let sut = makeSUT(.king, color: .white)
        sut.update(type: .pawn, color: .black)
        XCTAssertEqual(sut.type, PieceType.pawn)
        XCTAssertEqual(sut.color, PieceColor.black)
    }
    
    private func makeSUT(_ type: PieceType, color: PieceColor) -> Piece {
        let piece = Piece(type, color: color)
        return piece
    }

}
