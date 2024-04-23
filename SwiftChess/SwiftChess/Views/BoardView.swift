//
//  BoardView.swift
//  SwiftChess
//
//  Created by Miguel Duran on 22-04-24.
//

import UIKit

class BoardView: UIView {
    
    let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let board: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let boardStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.spacing = 0
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    private func setUpView() {
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.board)
        self.board.addSubview(self.boardStackView)
        
        let screenSize: CGRect = UIScreen.main.bounds
        let boardHeight = screenSize.width
        let squareSize = (boardHeight - 64) / 8
        
        NSLayoutConstraint.activate([
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.contentView.heightAnchor.constraint(equalToConstant: boardHeight)
        ])
        
        NSLayoutConstraint.activate([
            self.board.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 32.0),
            self.board.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 32.0),
            self.board.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -32.0),
            self.board.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -32.0)
        ])
        
        for i in 0...7  {
            let stackView = UIStackView()
            stackView.spacing = 0
            stackView.axis = .horizontal
            boardStackView.addArrangedSubview(stackView)
            for j in 0...7 {
                var image: UIImage? {
                    let imageFirstLight = j % 2 == 0 ? UIImage(named: "square_gray_light") : UIImage(named: "square_gray_dark")
                    let imageFirstDark = j % 2 == 0 ? UIImage(named: "square_gray_dark") : UIImage(named: "square_gray_light")
                    return i % 2 == 0 ? imageFirstLight : imageFirstDark
                }
                let imageView = UIImageView(image: image)
                stackView.addArrangedSubview(imageView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: squareSize),
                    imageView.heightAnchor.constraint(equalToConstant: squareSize)
                ])
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
