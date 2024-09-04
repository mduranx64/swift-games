//
//  MainViewController.swift
//  SwiftGames
//
//  Created by Miguel Duran on 14-04-24.
//

import UIKit

enum Game {
    case chess
    case comingSoon
}

typealias GameItem = (title: String, image: UIImage?, game: Game)

class MainViewController: UIViewController {
    
    let gameList: [GameItem] = [
        ("Chess", UIImage.chessCover, .chess),
        ("Coming Soon", nil, .comingSoon),
        ("Coming Soon", nil, .comingSoon),
        ("Coming Soon", nil, .comingSoon),
        ("Coming Soon", nil, .comingSoon)
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
        self.navigationItem.title = "Open board games"
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        let item = gameList[indexPath.row]
        cell.titleLabel.text = item.title
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
            navigationController?.pushViewController(ChessViewController(), animated: true)
        case .comingSoon:
            break
        }
    }
}

