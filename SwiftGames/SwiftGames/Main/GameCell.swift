//
//  GameCell.swift
//  SwiftGames
//
//  Created by Miguel Duran on 03-09-24.
//

import Foundation
import UIKit

class GameCell: UICollectionViewCell {
    
    let cornerRadius: CGFloat = 5.0
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "ChalkboardSE-Regular", size: 16.0)
        view.textColor = .text
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = .bKing
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .lightGray
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = cornerRadius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupViews() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
        
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
