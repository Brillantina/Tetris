//
//  PlayView.swift
//  Tetris
//
//  Created by Rita Marrano on 16/04/23.
//

import SwiftUI

struct PlayView: View {
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center) {
                
                Text("Are you ready to play your Tetris?")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .frame(width: 400, height: 100)

                
                //: Button
                Button {
                    //someaction
                } label: {
                    ButtonPlayView ()
                }
            }.navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
