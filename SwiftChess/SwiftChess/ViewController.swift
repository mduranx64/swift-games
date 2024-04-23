//
//  ViewController.swift
//  SwiftChess
//
//  Created by Miguel Duran on 14-04-24.
//

import UIKit

class ViewController: UIViewController {
    
    let boardView = BoardView()

    override func loadView() {
        self.view = self.boardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
    }
}

