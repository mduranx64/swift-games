//
//  UICollectionViewExtension.swift
//  SwiftGames
//
//  Created by Miguel Duran on 04-09-24.
//

import Foundation
import UIKit

public extension UICollectionView {
    func registerCell(withClass cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<CellType: UICollectionViewCell>(at indexPath: IndexPath) -> CellType {
        let identifier = String(describing: CellType.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CellType
    }
}
