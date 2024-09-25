//
//  Extensions.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 24-09-24.
//

import UIKit

extension UIDeviceOrientation {
    var isVertical: Bool {
        switch self {
        case .portrait, .unknown, .faceUp:
            return true
        default:
            return false
        }
    }
}
