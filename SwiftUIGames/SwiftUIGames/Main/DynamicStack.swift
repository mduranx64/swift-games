//
//  DynamicStack.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 08-09-24.
//

import SwiftUI

struct DynamicStack<Content: View>: View {
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    @ViewBuilder var content: () -> Content
    
    @Environment(\.verticalSizeClass) private var sizeClass

    var body: some View {
        switch sizeClass {
        case .regular:
            vStack
        case .compact, .none:
            hStack
        @unknown default:
            vStack
        }
    }
}

private extension DynamicStack {
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
