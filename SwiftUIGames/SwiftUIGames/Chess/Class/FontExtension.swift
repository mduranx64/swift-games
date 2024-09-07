//
//  FontExtension.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 07-09-24.
//

import Foundation
import SwiftUI

extension Font {
    enum App: String {
        case chalkboardSERegular = "ChalkboardSE-Regular"
        case chalkboardSEBold = "ChalkboardSE-Bold"
        
        func of(size: CGFloat) -> Font {
            Font.custom(self.rawValue, size: size)
        }
    }
}
