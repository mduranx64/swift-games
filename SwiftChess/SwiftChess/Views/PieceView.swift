//
//  PieceView.swift
//  SwiftChess
//
//  Created by Miguel Duran on 24-08-24.
//

import UIKit

class PieceView: UIImageView {
    var type: PieceType
    var color: PieceColor
    var isSelected = false
    let position: Position
    
    init(image: UIImage?, position: Position, type: PieceType, color: PieceColor) {
        self.position = position
        self.type = type
        self.color = color
        super.init(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(image: UIImage?, type: PieceType, color: PieceColor) {
        self.image = image
        self.type = type
        self.color = color
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
