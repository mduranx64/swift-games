//
//  ChessViewController.swift
//  SwiftGames
//
//  Created by Miguel Duran on 03-09-24.
//

import UIKit

class ChessViewController: UIViewController {

    lazy var board = Board()
    lazy var boardView = BoardView(board: board)

    override func loadView() {
        self.view = self.boardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
    }
}
