//
//  ViewController.swift
//  SwiftChess
//
//  Created by Miguel Duran on 14-04-24.
//

import UIKit

class ViewController: UIViewController {
    
    class ViewController: UIViewController {
        
        override func loadView() {
            super.loadView()
            debugPrint("loadView")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            debugPrint("viewDidLoad")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            debugPrint("viewWillAppear")
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            debugPrint("viewWillLayoutSubviews")
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            debugPrint("viewDidLayoutSubviews")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            debugPrint("viewDidAppear")
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            debugPrint("viewDidDisappear")
        }
        
        deinit {
            debugPrint("deinit - ViewController")
        }
        
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            debugPrint("viewWillTransition")
        }
    }
}

