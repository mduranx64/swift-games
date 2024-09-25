//
//  DynamicStackOrientation.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 24-09-24.
//

import SwiftUI

struct DynamicStackOrientation<Content: View>: View {
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    @Binding var orientation: UIDeviceOrientation
    @ViewBuilder var content: () -> Content
    

    var body: some View {
        switch orientation {
        case .portrait, .unknown, .faceUp:
            vStack
        case .landscapeLeft, .landscapeRight:
            hStack
        default:
            vStack
        }
    }
}

private extension DynamicStackOrientation {
    var hStack: some View {
        HStack(
            alignment: verticalAlignment,
            spacing: spacing,
            content: content
        )
    }

    var vStack: some View {
        VStack(
            alignment: horizontalAlignment,
            spacing: spacing,
            content: content
        )
    }
}
