//
//  SGButton.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 08-09-24.
//

import SwiftUI

struct SGButton: View {
    var title: String
    var action: () -> Void // Action closure that gets executed when the button is tapped
    
    var body: some View {
        Button(action: {
            action() // Perform the action passed to the button
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .font(Font.App.chalkboardSERegular.of(size: 16)) // Custom font
                .foregroundColor(Color.gameText) // Custom text color
        }
        .clipShape(RoundedRectangle(cornerRadius: 5)) // Rounded corners
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gameText, lineWidth: 1) // Rounded border
        )
    }
}

struct SGButton_Previews: PreviewProvider {
    static var previews: some View {
        SGButton(title: "Accept", action: {
            print("Button tapped!")
        })
        .padding()
    }
}
