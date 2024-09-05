//
//  Constants.swift
//  SwiftGames
//
//  Created by Miguel Duran on 04-09-24.
//

import Foundation
import UIKit

public struct Constants {

    enum Fonts: String {
        case chalkboardSERegular = "ChalkboardSE-Regular"
        
        func of(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: self.rawValue, size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
    }
}
