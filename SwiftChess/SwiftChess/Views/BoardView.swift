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
    
    let letterLeftStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let letterTopStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let letterRightStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let letterBottomStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.spacing = 0
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
        self.contentView.addSubview(letterLeftStackView)
        self.contentView.addSubview(letterTopStackView)
        self.contentView.addSubview(letterRightStackView)
        self.contentView.addSubview(letterBottomStackView)

        
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
            letterTopStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            letterTopStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            letterTopStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            letterTopStackView.bottomAnchor.constraint(equalTo: board.topAnchor)
        ])

        NSLayoutConstraint.activate([
            letterBottomStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            letterBottomStackView.topAnchor.constraint(equalTo: board.bottomAnchor),
            letterBottomStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            letterBottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            letterLeftStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            letterLeftStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            letterLeftStackView.rightAnchor.constraint(equalTo: board.leftAnchor),
            letterLeftStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            letterRightStackView.leftAnchor.constraint(equalTo: board.rightAnchor),
            letterRightStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            letterRightStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            letterRightStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
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

        let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
        let numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
        
        addTextGuideToBoard(letterTopStackView, array: letters, width: squareSize, height: 32.0)
        addTextGuideToBoard(letterBottomStackView, array: letters, width: squareSize, height: 32.0)
        addTextGuideToBoard(letterLeftStackView, array: numbers.reversed(), width: 32.0, height: squareSize)
        addTextGuideToBoard(letterRightStackView, array: numbers.reversed(), width: 32.0, height: squareSize)
        
    }
    
    func addTextGuideToBoard(_ stackView: UIStackView, array: [String], width: CGFloat, height: CGFloat) {
        for char in array {
            let label = UILabel(frame: .zero)
            label.textAlignment = .center
            label.text = char
            label.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(label)
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: width),
                label.heightAnchor.constraint(equalToConstant: height)
            ])
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
