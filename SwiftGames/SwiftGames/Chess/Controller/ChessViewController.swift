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
        setupView()
        setupNavigationBar()
    }
    
    private func setupView() {
        self.view.backgroundColor = .background
    }
    
    private func setupNavigationBar() {
        
        self.navigationItem.title = NSLocalizedString("Chess", comment: "")
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text, NSAttributedString.Key.font: Constants.Fonts.chalkboardSERegular.of(size: 18)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let exitItem = UIBarButtonItem(title: NSLocalizedString("Exit", comment: ""), style: .plain, target: self, action: #selector(exitAction))
        exitItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.text, NSAttributedString.Key.font: Constants.Fonts.chalkboardSERegular.of(size: 18)], for: .normal)
        navigationItem.leftBarButtonItem = exitItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showInfo))
    }
    
    @objc func showInfo() {
        
    }
    
    @objc func exitAction() {
        self.dismiss(animated: true)
    }
}
