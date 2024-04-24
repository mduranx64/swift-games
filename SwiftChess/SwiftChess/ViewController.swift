//
//  ViewController.swift
//  SwiftChess
//
//  Created by Miguel Duran on 14-04-24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var board = Board()
    lazy var boardView = BoardView(pieces: board.pieces)

    override func loadView() {
        self.view = self.boardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
    }
}

