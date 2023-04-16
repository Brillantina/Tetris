//
//  StartView.swift
//  Tetris
//
//  Created by Rita Marrano on 16/04/23.
//

import SwiftUI

struct ButtonPlayView: View {
    
    var body: some View {
        
        Button(action: {
            print("PLAY")
        }, label: {
            NavigationLink(destination: GameView()) {

                Text ("PLAY")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.title)
                    .frame(width: 130, height: 60, alignment: .center)
            }
        })  .padding(.horizontal, 50)
            
            .background(
                Capsule().strokeBorder(Color.black, lineWidth: 3)
                    .background(Color(.brown))
                    .opacity(0.7)
                    .cornerRadius(30)
            )
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPlayView()
    }
}
