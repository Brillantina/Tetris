//
//  PlayerBoardView.swift
//  Tetris
//
//  Created by Rita Marrano on 30/04/23.
//

import Foundation

import SwiftUI

struct PlayerBoardView: View {
    

    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    @State var letters : [Character]
    @Binding var letterSelected: Character?
//    @State var letterChosen: LetterRect?
    
    var body: some View {
        
        
        GeometryReader{ geometry in
            VStack{
           
                LazyVGrid(columns: columns, spacing: 5){
                    
                    ForEach(letters, id: \.self){ letter in
                        
                        ZStack{
                            Button(action: {
                                self.letterSelected = letter
                                
                            }) {
                                
                                ZStack{
                                    Rectangle()
                                        .cornerRadius(16)
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(letterSelected == letter ? Color.blue : Color.brown)
                                    
                                    
                                    Text(letter.description)
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .foregroundColor(letterSelected == letter ? .white : .black)
                                    
                                    
                                    
                                }

                            }
                        }                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                        

                    }

                }
                Spacer()
            }

        }

        }
    


    }


//struct PlayerBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerBoardView( letterSelected: <#Binding<Character?>#>)
//    }
//}

