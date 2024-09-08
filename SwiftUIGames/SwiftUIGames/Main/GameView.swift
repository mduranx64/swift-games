//
//  GameView.swift
//  SwiftUIGames
//
//  Created by Miguel Duran on 06-09-24.
//

import SwiftUI

struct GameView: View {
    var title: String
    var image: Image
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
                .aspectRatio(619/493, contentMode: .fit)
            
            Text(title)
                .font(Font.App.chalkboardSERegular.of(size: 16))
                .foregroundColor(Color.gameText)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.viewBackground)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gameText, lineWidth: 1) // Rounded border
        )

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(title: "Chess", image: Image(.chessCover))
    }
}
