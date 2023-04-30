//
//  GameSquareView.swift
//  Tetris
//
//  Created by Rita Marrano on 30/04/23.
//

import SwiftUI

struct GameSquareView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
  
    
    
    var body: some View{
        
        
        GeometryReader{ geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: columns, spacing: 5){
                    
                    ForEach(0..<9){ i in
                                ZStack{
                        
                                    Circle()
                                        .foregroundColor(.black)
                                        .frame(width: 110,height: 110)
                                        .opacity(0.6)
                        
                                    Circle()
                                        .foregroundColor(.brown)
                                        .opacity(0.9)
                                        .frame(width: 100, height: 100)
                        
  
                        
                                }                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                        .onTapGesture {
                            
                            print("boardindex\(i)")

 
                        }
                    }

                }
                Spacer()
            }

        }
    }
        
        
      
    
}

struct GameSquareView_Previews: PreviewProvider {
    static var previews: some View {
        GameSquareView()
    }
}
