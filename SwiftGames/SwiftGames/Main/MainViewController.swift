//
//  MainViewController.swift
//  SwiftGames
//
//  Created by Miguel Duran on 14-04-24.
//
import Foundation
import UIKit

enum Game {
    case chess
    case comingSoon
}

typealias GameItem = (title: String, image: UIImage?, game: Game)

class MainViewController: UIViewController {
    
    let gameList: [GameItem] = [
        (NSLocalizedString("Chess", comment: ""), UIImage.chessCover, .chess),
        (NSLocalizedString("Coming soon", comment: ""), nil, .comingSoon),
        (NSLocalizedString("Coming soon", comment: ""), nil, .comingSoon),
        (NSLocalizedString("Coming soon", comment: ""), nil, .comingSoon),
        (NSLocalizedString("Coming soon", comment: ""), nil, .comingSoon)
    ]
    
    lazy var margin: CGFloat = 16.0
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.collectionViewLayout = layout
        view.backgroundColor = .background
        return view
    }()
    
    override func loadView() {
        self.view = self.collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        collectionView.registerCell(withClass:GameCell.self)

        self.navigationItem.title = NSLocalizedString("Swift Games", comment: "")
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text, NSAttributedString.Key.font: Constants.Fonts.chalkboardSERegular.of(size: 18)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showInfo))
    }
    
    @objc func showInfo() {
        
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GameCell = collectionView.dequeueReusableCell(at: indexPath)
        let item = gameList[indexPath.row]
        cell.titleLabel.text = NSLocalizedString(item.title, comment: "") 
        cell.imageView.image = item.image
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - (margin * 3)) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = gameList[indexPath.row]
        navigateToGame(item.game)
    }
    
    func navigateToGame(_ game: Game) {
        switch game {
        case .chess:
            let controller = ChessViewController()
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            navigationController?.present(navigation, animated: true)
        case .comingSoon:
            break
        }
    }
}

