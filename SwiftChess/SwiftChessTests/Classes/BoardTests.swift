//
//  BoardTests.swift
//  SwiftChessTests
//
//  Created by Miguel Duran on 18-04-24.
//

import XCTest
@testable import SwiftChess

final class BoardTests: XCTestCase {
    
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
        let piece = board.getPieceByPosition(Position(x: 6, y: 0))
        checkPiece(piece, type: .pawn, color: .white)
        let pieceEmpty = board.getPieceByPosition(Position(x: 5, y: 0))
        XCTAssertNil(pieceEmpty?.type)
    }
    
    func testMovePieceEmpty() {
        let board = makeSUT()
        let isMoved = board.movePiece(from: Position(x: 5, y: 0), to: Position(x: 5, y: 0))
        XCTAssertFalse(isMoved)
    }
    
    func testMoveWhitePawnOne() {
        checkPieceMove(from: Position(x: 6, y: 0), to: Position(x: 5, y: 0), type: .pawn, color: .white)

    }
    
    func testMoveWhitePawnTwo() {
        checkPieceMove(from: Position(x: 6, y: 0), to:  Position(x: 4, y: 0), type: .pawn, color: .white)
    }
    
    func testMoveBlackPawnOne() {
        checkPieceMove(from: Position(x: 1, y: 1), to: Position(x: 2, y: 1), type: .pawn, color: .black)
    }
    
    func testMoveBlackPawnTwo() {
        checkPieceMove(from: Position(x: 1, y: 1), to: Position(x: 3, y: 1), type: .pawn, color: .black)
    }
    
    func testMoveKnight() {
        let sut = makeSUT()
        checkPieceMove(sut, from: Position(x: 0, y: 1), to: Position(x: 2, y: 2), type: .knight, color: .black)
        checkPieceMove(sut,from: Position(x: 2, y: 2), to: Position(x: 4, y: 1), type: .knight, color: .black)
        checkPieceMove(sut,from: Position(x: 4, y: 1), to: Position(x: 5, y: 3), type: .knight, color: .black)
        checkPieceMove(sut,from: Position(x: 5, y: 3), to: Position(x: 4, y: 5), type: .knight, color: .black)
        checkPieceMove(sut,from: Position(x: 4, y: 5), to: Position(x: 3, y: 3), type: .knight, color: .black)
        checkPieceMove(sut,from: Position(x: 3, y: 3), to: Position(x: 4, y: 1), type: .knight, color: .black)
        
        checkPieceMove(sut,from: Position(x: 7, y: 6), to: Position(x: 5, y: 5), type: .knight, color: .white)
        checkPieceMove(sut,from: Position(x: 5, y: 5), to: Position(x: 3, y: 6), type: .knight, color: .white)
    }
    
    func testMoveRookRight() {
        let sut = makeSUT()
        XCTAssertTrue(sut.movePiece(from: Position(x: 6, y: 0), to: Position(x: 4, y: 0)))
        XCTAssertTrue(sut.movePiece(from: Position(x: 7, y: 0), to: Position(x: 5, y: 0)))
        checkPieceMove(sut, from: Position(x: 5, y: 0), to: Position(x: 5, y: 2), type: .rook, color: .white)
    }
    
    func testMoveRookRightCollision() {
        let sut = makeSUT()
        XCTAssertTrue(sut.movePiece(from: Position(x: 6, y: 0), to: Position(x: 4, y: 0)))
        XCTAssertTrue(sut.movePiece(from: Position(x: 7, y: 0), to: Position(x: 5, y: 0)))
        XCTAssertTrue(sut.movePiece(from: Position(x: 6, y: 1), to: Position(x: 5, y: 1)))
        checkPieceMoveCollision(sut, from: Position(x: 5, y: 0), to: Position(x: 5, y: 2))
    }
    
    func testMoveRookLeft() {
        let sut = makeSUT()
        XCTAssertTrue(sut.movePiece(from: Position(x: 6, y: 7), to: Position(x: 4, y: 7)))
        XCTAssertTrue(sut.movePiece(from: Position(x: 7, y: 7), to: Position(x: 5, y: 7)))
        checkPieceMove(sut, from: Position(x: 5, y: 7), to: Position(x: 5, y: 5), type: .rook, color: .white)
    }
    
    func testMoveRookLeftCollision() {
        let sut = makeSUT()
        XCTAssertTrue(sut.movePiece(from: Position(x: 6, y: 7), to: Position(x: 4, y: 7)))
        XCTAssertTrue(sut.movePiece(from: Position(x: 6, y: 6), to: Position(x: 5, y: 6)))
        XCTAssertTrue(sut.movePiece(from: Position(x: 7, y: 7), to: Position(x: 5, y: 7)))
        checkPieceMoveCollision(sut, from: Position(x: 5, y: 7), to: Position(x: 5, y: 5))
    }
    
    func testMoveRookDown() {
        let sut = makeSUT()
        XCTAssertTrue(sut.movePiece(from: Position(x: 1, y: 0), to: Position(x: 3, y: 0)))
        checkPieceMove(sut, from: Position(x: 0, y: 0), to: Position(x: 2, y: 0), type: .rook, color: .black)
    }
    
    func testMoveRookDownCollision() {
        checkPieceMoveCollision(from: Position(x: 0, y: 0), to: Position(x: 2, y: 0))
    }
    
    func testMoveUpDown() {
        let sut = makeSUT()
        XCTAssertTrue(sut.movePiece(from: Position(x: 6, y: 7), to: Position(x: 4, y: 7)))
        checkPieceMove(sut, from: Position(x: 7, y: 7), to: Position(x: 5, y: 7), type: .rook, color: .white)
    }
    
    func testMoveRookUpCollision() {
        checkPieceMoveCollision(from: Position(x: 7, y: 7), to: Position(x: 5, y: 7))
    }
    
    func testMoveKing() {
        let sut = makeSUT()
        checkPieceMove(sut, from: Position(x: 6, y: 5), to: Position(x: 5, y: 5), type: .pawn, color: .white)
        
        checkPieceMove(sut, from: Position(x: 7, y: 4), to: Position(x: 6, y: 5), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 6, y: 5), to: Position(x: 5, y: 4), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 5, y: 4), to: Position(x: 4, y: 5), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 5), to: Position(x: 5, y: 4), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 5, y: 4), to: Position(x: 6, y: 5), type: .king, color: .white)
        
        checkPieceMove(sut, from: Position(x: 6, y: 5), to: Position(x: 5, y: 6), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 5, y: 6), to: Position(x: 4, y: 6), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 6), to: Position(x: 4, y: 7), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 7), to: Position(x: 5, y: 7), type: .king, color: .white)
        checkPieceMove(sut, from: Position(x: 5, y: 7), to: Position(x: 5, y: 6), type: .king, color: .white)
    }
    
    func testMoveBishop() {
        let sut = makeSUT()
        checkPieceMove(sut, from: Position(x: 6, y: 1), to: Position(x: 5, y: 1), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 6, y: 3), to: Position(x: 5, y: 3), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 7, y: 2), to: Position(x: 5, y: 0), type: .bishop, color: .white)
        checkPieceMove(sut, from: Position(x: 5, y: 0), to: Position(x: 3, y: 2), type: .bishop, color: .white)
        checkPieceMove(sut, from: Position(x: 3, y: 2), to: Position(x: 5, y: 4), type: .bishop, color: .white)
        checkPieceMove(sut, from: Position(x: 5, y: 4), to: Position(x: 7, y: 2), type: .bishop, color: .white)
    }
    
    func testMoveBishopCollision() {
        checkPieceMoveCollision(from: Position(x: 7, y: 2), to: Position(x: 5, y: 0))
        checkPieceMoveCollision(from: Position(x: 7, y: 2), to: Position(x: 5, y: 4))
        
        checkPieceMoveCollision(from: Position(x: 0, y: 2), to: Position(x: 2, y: 0))
        checkPieceMoveCollision(from: Position(x: 0, y: 2), to: Position(x: 2, y: 4))
    }
    
    func testMoveQueen() {
        let sut = makeSUT()
        checkPieceMove(sut, from: Position(x: 6, y: 2), to: Position(x: 5, y: 2), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 7, y: 3), to: Position(x: 4, y: 0), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 0), to: Position(x: 3, y: 0), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 3, y: 0), to: Position(x: 3, y: 1), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 3, y: 1), to: Position(x: 4, y: 1), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 1), to: Position(x: 4, y: 0), type: .queen, color: .white)
        
        checkPieceMove(sut, from: Position(x: 4, y: 0), to: Position(x: 3, y: 1), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 3, y: 1), to: Position(x: 4, y: 2), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 2), to: Position(x: 5, y: 1), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 5, y: 1), to: Position(x: 4, y: 0), type: .queen, color: .white)
    }

    func testMoveQueenCollision() {
        checkPieceMoveCollision(from: Position(x: 7, y: 3), to: Position(x: 5, y: 1))
        checkPieceMoveCollision(from: Position(x: 7, y: 3), to: Position(x: 5, y: 3))
        checkPieceMoveCollision(from: Position(x: 7, y: 3), to: Position(x: 5, y: 5))
    
        checkPieceMoveCollision(from: Position(x: 0, y: 3), to: Position(x: 2, y: 1))
        checkPieceMoveCollision(from: Position(x: 0, y: 3), to: Position(x: 2, y: 3))
        checkPieceMoveCollision(from: Position(x: 0, y: 3), to: Position(x: 2, y: 5))
        
        let sut = makeSUT()
        checkPieceMove(sut, from: Position(x: 6, y: 3), to: Position(x: 4, y: 3), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 6, y: 2), to: Position(x: 5, y: 2), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 6, y: 4), to: Position(x: 5, y: 4), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 7, y: 3), to: Position(x: 5, y: 3), type: .queen, color: .white)
        
        checkPieceMoveCollision(sut, from: Position(x: 5, y: 3), to: Position(x: 5, y: 1))
        checkPieceMoveCollision(sut, from: Position(x: 5, y: 3), to: Position(x: 5, y: 5))
    }
    
    func testMoveWhitePawnCaptureBlack() {
        let sut = makeSUT()
        checkPieceMove(sut, from: Position(x: 1, y: 0), to: Position(x: 3, y: 0), type: .pawn, color: .black)
        checkPieceMove(sut, from: Position(x: 3, y: 0), to: Position(x: 4, y: 0), type: .pawn, color: .black)
        checkPieceMove(sut, from: Position(x: 4, y: 0), to: Position(x: 5, y: 0), type: .pawn, color: .black)
        checkPieceMove(sut, from: Position(x: 6, y: 1), to: Position(x: 5, y: 0), type: .pawn, color: .white)
        
        checkPieceMove(sut, from: Position(x: 1, y: 3), to: Position(x: 3, y: 3), type: .pawn, color: .black)
        checkPieceMove(sut, from: Position(x: 3, y: 3), to: Position(x: 4, y: 3), type: .pawn, color: .black)
        checkPieceMove(sut, from: Position(x: 4, y: 3), to: Position(x: 5, y: 3), type: .pawn, color: .black)
        checkPieceMove(sut, from: Position(x: 6, y: 2), to: Position(x: 5, y: 3), type: .pawn, color: .white)
    }
    
    func testMoveBlackPawnCaptureWhite() {
        let sut = makeSUT()
        checkPieceMove(sut, from: Position(x: 6, y: 0), to: Position(x: 4, y: 0), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 0), to: Position(x: 3, y: 0), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 3, y: 0), to: Position(x: 2, y: 0), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 1, y: 1), to: Position(x: 2, y: 0), type: .pawn, color: .black)
        
        checkPieceMove(sut, from: Position(x: 6, y: 3), to: Position(x: 4, y: 3), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 4, y: 3), to: Position(x: 3, y: 3), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 3, y: 3), to: Position(x: 2, y: 3), type: .pawn, color: .white)
        checkPieceMove(sut, from: Position(x: 1, y: 2), to: Position(x: 2, y: 3), type: .pawn, color: .black)
    }
    
    // positions of the pieces in the matrix
    //[0,0][0,1][0,2][0,3][0,4][0,5][0,6][0,7]
    //[1,0][1,1][1,2][1,3][1,4][1,5][1,6][1,7]
    //[2,0][2,1][2,2][2,3][2,4][2,5][2,6][2,7]
    //[3,0][3,1][3,2][3,3][3,4][3,5][3,6][3,7]
    //[4,0][4,1][4,2][4,3][4,4][4,5][4,6][4,7]
    //[5,0][5,1][5,2][5,3][5,4][5,5][5,6][5,7]
    //[6,0][6,1][6,2][6,3][6,4][6,5][6,6][6,7]
    //[7,0][7,1][7,2][7,3][7,4][7,5][7,6][7,7]
    
    func testMoveRookCapture() {
        let wr1 = Piece(.rook, color: .white)
        let br1 = Piece(.rook, color: .black)
        let wr2 = Piece(.rook, color: .white)
        let br2 = Piece(.rook, color: .black)

        let pieces = [
            [br1, nil, nil, nil, nil, nil, nil, br2],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [wr1, nil, nil, nil, nil, nil, nil, wr2]
        ]
        let sut = makeSUT(pieces: pieces)
        checkPieceMove(sut, from: Position(x: 7, y: 0), to: Position(x: 0, y: 0), type: .rook, color: .white)
        checkPieceMove(sut, from: Position(x: 0, y: 7), to: Position(x: 7, y: 7), type: .rook, color: .black)
    }
    
    func testMoveKnightCapture() {
        let wkt = Piece(.knight, color: .white)
        let bpn = Piece(.pawn, color: .black)

        let pieces = [
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [bpn, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, wkt, nil, nil, nil, nil, nil, nil]
        ]
        let sut = makeSUT(pieces: pieces)
        checkPieceMove(sut, from: Position(x: 7, y: 1), to: Position(x: 5, y: 0), type: .knight, color: .white)
    }
    
    func testMoveBishopCapture() {
        let wbp = Piece(.bishop, color: .white)
        let bpn = Piece(.pawn, color: .black)

        let pieces = [
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [bpn, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, wbp, nil, nil, nil, nil, nil]
        ]
        let sut = makeSUT(pieces: pieces)
        checkPieceMove(sut, from: Position(x: 7, y: 2), to: Position(x: 5, y: 0), type: .bishop, color: .white)
    }
    
    func testMoveQueenCapture() {
        let wqn = Piece(.queen, color: .white)
        let bpn = Piece(.pawn, color: .black)
        let bqn = Piece(.queen, color: .black)
        let wpn = Piece(.pawn, color: .white)

        let pieces = [
            [nil, nil, nil, bqn, nil, nil, nil, nil],
            [nil, nil, nil, wpn, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [bpn, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, wqn, nil, nil, nil, nil]
        ]
        let sut = makeSUT(pieces: pieces)
        checkPieceMove(sut, from: Position(x: 7, y: 3), to: Position(x: 5, y: 0), type: .queen, color: .white)
        checkPieceMove(sut, from: Position(x: 0, y: 3), to: Position(x: 1, y: 3), type: .queen, color: .black)
    }
    
    func testMoveKingCapture() {
        let wkg = Piece(.king, color: .white)
        let bpn = Piece(.pawn, color: .black)

        let pieces = [
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, bpn, nil, nil, nil, nil],
            [nil, nil, nil, nil, wkg, nil, nil, nil]
        ]
        let sut = makeSUT(pieces: pieces)
        checkPieceMove(sut, from: Position(x: 7, y: 4), to: Position(x: 6, y: 3), type: .king, color: .white)
    }

    private func makeSUT(pieces: [[Piece?]]) -> Board {
        return Board(pieces: pieces)
    }
                     
     private func makeSUT() -> Board {
         return Board()
     }
    
    private func checkPiece(_ piece: Piece?, type: PieceType, color: PieceColor) {
        XCTAssertEqual(piece?.type, type)
        XCTAssertEqual(piece?.color, color)
    }
    
    private func checkPieceMove(_ board: Board = Board(), from: Position, to: Position, type: PieceType, color: PieceColor) {
        let isMoved = board.movePiece(from: from, to: to)
        let origin = board.getPieceByPosition(from)
        let destiny = board.getPieceByPosition(to)
        XCTAssertTrue(isMoved)
        XCTAssertEqual(origin?.type, nil)
        XCTAssertEqual(origin?.color, nil)
        XCTAssertEqual(destiny?.type, type)
        XCTAssertEqual(destiny?.color, color)
    }
    
    private func checkPieceMoveCollision(_ board: Board = Board(), from: Position, to: Position) {
        let isMoved = board.movePiece(from: from, to: to)
        XCTAssertFalse(isMoved)
    }
}
