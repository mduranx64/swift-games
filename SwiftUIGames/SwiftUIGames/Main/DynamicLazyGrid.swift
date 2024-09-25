//
//  DynamicLazyGrid.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 24-09-24.
//

import SwiftUI

struct DynamicLazyGrid<Content: View>: View {
    var gridItems: [GridItem]
    var vAlignment: VerticalAlignment = .center
    var hAlignment: HorizontalAlignment = .center
    var spacing: CGFloat? = nil
    var pinnedViews: PinnedScrollableViews = .init()
    @Binding var orientation: UIDeviceOrientation
    @ViewBuilder var content: () -> Content

    var body: some View {
        switch orientation {
        case .portrait, .unknown, .faceUp:
            lazyVGrid
        case .landscapeLeft, .landscapeRight:
            lazyHGrid
        default:
            lazyVGrid
        }
    }
}

private extension DynamicLazyGrid {
    var lazyHGrid: some View {
        LazyHGrid(
            rows: gridItems,
            alignment: vAlignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }

    var lazyVGrid: some View {
        LazyVGrid(
            columns: gridItems,
            alignment: hAlignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content
        )
    }
}
