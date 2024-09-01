//
//  PieceViewTests.swift
//  SwiftChessTests
//
//  Created by Miguel Duran on 31-08-24.
//

import XCTest
@testable import SwiftChess

final class PieceViewTests: XCTestCase {
    

    func testPieceViewBorder() {
        let sut = makeSUT()
        XCTAssertFalse(sut.isSelected)
        sut.addBorder()
        XCTAssertTrue(sut.isSelected)
        sut.removeBorder()
        XCTAssertFalse(sut.isSelected)
    }
    
    func testPieceViewUpdateImage() {
        let sut = makeSUT()
        sut.update(image: .wKing, type: .king, color: .white)
        XCTAssertEqual(sut.color, PieceColor.white)
        XCTAssertEqual(sut.type, PieceType.king)
    }

    private func makeSUT() -> PieceView {
        return PieceView(image: .bBishop, position: .init(x: 0, y: 0), type: .bishop, color: .black)
    }

}
