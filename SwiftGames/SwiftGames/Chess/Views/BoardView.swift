//
//  BoardView.swift
//  SwiftGames
//
//  Created by Miguel Duran on 22-04-24.
//

import UIKit
import AVFoundation

class BoardView: UIView {
    
    let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let boardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
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
    
    let piecesStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0...7 {
            let stackView = UIStackView()
            stackView.spacing = 0
            stackView.axis = .horizontal
            view.addArrangedSubview(stackView)
        }
        return view
    }()
    
    var board: Board
    lazy var screenSize: CGRect = UIScreen.main.bounds
    lazy var boardHeight = min(screenSize.width, screenSize.height)
    lazy var squareSize = (boardHeight - 64) / 8
    var selectedPieceView: PieceView?
    var destinyPieceView: PieceView?
    var startPiece: PieceColor
    
    init(board: Board, startPiece: PieceColor = .white) {
        self.board = board
        self.startPiece = startPiece
        super.init(frame: .zero)
        setUpView()
        setUpPieces(board.pieces)
        if startPiece == .black {
            rotateView(contentView)
        }
    }
    
    private func setUpView() {
        self.backgroundColor = .background
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.boardView)
        self.boardView.addSubview(self.boardStackView)
        self.contentView.addSubview(letterLeftStackView)
        self.contentView.addSubview(letterTopStackView)
        self.contentView.addSubview(letterRightStackView)
        self.contentView.addSubview(letterBottomStackView)
        self.boardView.addSubview(piecesStackView)

        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.contentView.heightAnchor.constraint(equalToConstant: boardHeight),
            self.contentView.widthAnchor.constraint(equalToConstant: boardHeight)
        ])
        
        NSLayoutConstraint.activate([
            self.boardView.leftAnchor.constraint(equalTo: boardStackView.leftAnchor),
            self.boardView.topAnchor.constraint(equalTo: boardStackView.topAnchor),
            self.boardView.rightAnchor.constraint(equalTo: boardStackView.rightAnchor),
            self.boardView.bottomAnchor.constraint(equalTo: boardStackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            letterTopStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            letterTopStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            letterTopStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            letterTopStackView.bottomAnchor.constraint(equalTo: boardView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            letterBottomStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            letterBottomStackView.topAnchor.constraint(equalTo: boardView.bottomAnchor),
            letterBottomStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            letterBottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            letterLeftStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            letterLeftStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            letterLeftStackView.rightAnchor.constraint(equalTo: boardView.leftAnchor),
            letterLeftStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            letterRightStackView.leftAnchor.constraint(equalTo: boardView.rightAnchor),
            letterRightStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            letterRightStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            letterRightStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            piecesStackView.leftAnchor.constraint(equalTo: boardView.leftAnchor),
            piecesStackView.topAnchor.constraint(equalTo: boardView.topAnchor),
            piecesStackView.rightAnchor.constraint(equalTo: boardView.rightAnchor),
            piecesStackView.bottomAnchor.constraint(equalTo: boardView.bottomAnchor)
        ])
        
        for i in 0...7  {
            let stackView = UIStackView()
            stackView.spacing = 0
            stackView.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
            boardStackView.addArrangedSubview(stackView)
            for j in 0...7 {
                var image: UIImage? {
                    let imageFirstLight = j % 2 == 0 ? UIImage.squareGrayLight : UIImage.squareGrayDark
                    let imageFirstDark = j % 2 == 0 ? UIImage.squareGrayDark : UIImage.squareGrayLight
                    return i % 2 == 0 ? imageFirstLight : imageFirstDark
                }
                let imageView = UIImageView(image: image)
                stackView.addArrangedSubview(imageView)
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: squareSize),
                    imageView.heightAnchor.constraint(equalToConstant: squareSize)
                ])
            }
        }

        let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
        let numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
        
        addTextGuideToBoard(letterTopStackView, array: letters, width: squareSize, height: 32.0, isRotated: true)
        addTextGuideToBoard(letterBottomStackView, array: letters, width: squareSize, height: 32.0)
        addTextGuideToBoard(letterLeftStackView, array: numbers.reversed(), width: 32.0, height: squareSize)
        addTextGuideToBoard(letterRightStackView, array: numbers.reversed(), width: 32.0, height: squareSize, isRotated: true)
        
    }
    
    func addTextGuideToBoard(_ stackView: UIStackView, array: [String], width: CGFloat, height: CGFloat, isRotated: Bool = false) {
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
            if isRotated {
                rotateView(label)
            }
        }
    }
    
    func setUpPieces(_ pieces: [[Piece?]]) {
        
        for (i, row) in pieces.enumerated() {
            let rowStackView = piecesStackView.arrangedSubviews[i] as? UIStackView
            for (j, piece) in row.enumerated() {

                let pieceImage = piece?.pieceImage

                let imageView = PieceView(image: pieceImage, position: Position(x: i, y: j), type: piece?.type, color: piece?.color)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPiece(_:))))
                imageView.contentMode = .scaleAspectFit
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: squareSize),
                    imageView.heightAnchor.constraint(equalToConstant: squareSize)
                ])
                rowStackView?.addArrangedSubview(imageView)
                if startPiece == .black {
                    self.rotateView(imageView)
                }
            }
        }
    }
    
    func updatePieces(_ pieces: [[Piece?]]) {
        for (i, row) in pieces.enumerated() {
            let rowStackView = piecesStackView.arrangedSubviews[i] as? UIStackView
            for (j, piece) in row.enumerated() {
                let view = rowStackView?.arrangedSubviews[j] as? PieceView
                view?.update(image: piece?.pieceImage, type: piece?.type, color: piece?.color)
            }
        }
    }
    
    private func rotateView(_ view: UIView) {
        let rotationDegrees =  180.0
        let rotationAngle = CGFloat(rotationDegrees * Double.pi / 180.0)
        view.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }

    @objc func selectPiece(_ sender: UITapGestureRecognizer) {
        let newPiece = sender.view as? PieceView
        debugPrint("selectPiece: \(newPiece?.type?.rawValue ?? "") color: \(newPiece?.color?.rawValue ?? "") x: \(newPiece?.position.x ?? 0) y: \(newPiece?.position.y ?? 0)")
        
        // select a piece
        if selectedPieceView == nil && newPiece?.type != nil && newPiece?.color == board.currentTurn {
            selectedPieceView = newPiece
            newPiece?.addBorder()
            debugPrint("piece selected")
            return
        }
        
        // piece is already selected
        if selectedPieceView === newPiece {
            newPiece?.removeBorder()
            selectedPieceView = nil
            debugPrint("piece deselected")
            return
        }
        
        // if space is empty
        if newPiece?.type == nil && selectedPieceView != nil {
            debugPrint("next space empty")
            guard let selected = selectedPieceView,
                  let destiny = newPiece else {
                return
            }
            if board.movePiece(from: selected.position, to: destiny.position) {
                updatePieces(board.pieces)
                selected.removeBorder()
                selectedPieceView = nil
                debugPrint("piece moved")
            }
            return
        }
        
        // if space has a piece
        if newPiece?.type != nil && selectedPieceView != nil  {
            debugPrint("next space has a piece")
            // if the piece is same color
            if newPiece?.color == selectedPieceView?.color,
               selectedPieceView?.type == .king && newPiece?.type == .rook {
                guard let selected = selectedPieceView,
                      let destiny = newPiece else {
                    return
                }
                if board.movePiece(from: selected.position, to: destiny.position) {
                    updatePieces(board.pieces)
                    selected.removeBorder()
                    selectedPieceView = nil
                    debugPrint("piece captured")
                } else {
                    selectedPieceView?.removeBorder()
                    newPiece?.addBorder()
                    selectedPieceView = newPiece
                    debugPrint("piece is same color")
                }
                
            } else if newPiece?.color == selectedPieceView?.color {
                selectedPieceView?.removeBorder()
                newPiece?.addBorder()
                selectedPieceView = newPiece
                debugPrint("piece is same color")
            } else {
                guard let selected = selectedPieceView,
                      let destiny = newPiece else {
                    return
                }
                if board.movePiece(from: selected.position, to: destiny.position) {
                    updatePieces(board.pieces)
                    selected.removeBorder()
                    selectedPieceView = nil
                    debugPrint("piece captured")
                }
            }
            return
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
