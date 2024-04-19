//
//  Board.swift
//  SwiftChess
//
//  Created by Miguel Duran on 18-04-24.
//

import Foundation

public class Board {
    
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
}
