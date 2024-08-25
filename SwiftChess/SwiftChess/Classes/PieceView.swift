//
//  PieceView.swift
//  SwiftChess
//
//  Created by Miguel Duran on 24-08-24.
//

import UIKit

class PieceView: UIImageView {
    var piece: Piece?
    
    init(image: UIImage?, piece: Piece?) {
        self.piece = piece
        super.init(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
