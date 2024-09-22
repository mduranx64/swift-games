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
    
    @Environment(\.verticalSizeClass) private var vSizeClass
    @Environment(\.horizontalSizeClass) private var hSizeClass

    var body: some View {
        switch (vSizeClass, hSizeClass) {
        case (.regular, .compact):
            vStack
        case (.compact, .regular):
            hStack
        case (.regular, .regular):
            hStack
        default:
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
