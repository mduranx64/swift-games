//
//  PieceView.swift
//  SwiftChess
//
//  Created by Miguel Duran on 24-08-24.
//

import UIKit

class PieceView: UIImageView {
    var piece: Piece?
    var isSelected = false
    
    init(image: UIImage?, piece: Piece?) {
        self.piece = piece
        super.init(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBorder() {
        let rectangleLayer = CAShapeLayer()
        rectangleLayer.frame = self.bounds
        let rectanglePath = UIBezierPath(rect: self.bounds)
        rectangleLayer.path = rectanglePath.cgPath
        rectangleLayer.strokeColor = UIColor.yellow.cgColor
        rectangleLayer.fillColor = UIColor.clear.cgColor
        rectangleLayer.lineWidth = 2.0
        self.layer.addSublayer(rectangleLayer)
        self.isSelected = true
    }
    
    func removeBorder() {
        self.layer.sublayers?.removeAll()
        self.isSelected = false
    }
}
