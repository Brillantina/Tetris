//
//  GameView.swift
//  Tetris
//
//  Created by Rita Marrano on 15/04/23.
//
import SwiftUI
import CoreData


let columns: [GridItem] = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),]

struct GameView: View {
    
    @StateObject  var vm = GameViewModel()

    @State var letter: Character?
    
    var body: some View {
        
        VStack{
            
            Text("score: \(vm.score)")
            GeometryReader{ geometry in
                ZStack{
                    
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
                                
                                PlayerIndicator(letter: vm.moves[i]?.letter ?? " ")
                                
                            }                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                            
                            
                                .onTapGesture {
                                    
                                    print("boardindex\(i)")
                                    
                                    if letter != nil {
                                        print("boardindex\(i) e lettera \(letter)")
                                        vm.processPlayerMove(for: i, letter:  letter ?? " " )
                                        print("move \(vm.moves)")
                                    }
                                    
                                }
                        }
                        
                    }
                    
                    
                }
            }
            
            ZStack{
                PlayerBoardView(letters: vm.gameLetters, letterSelected: $letter)
            }
        }
    }
    
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



enum Player {
    case human, computer
}


struct Move {
    let player: Player
    let boardIndex: Int
    let letter: Character
//    var indicator: Character {
//        return player == .human ? "H" : "C"
//    }
}





struct PlayerIndicator: View{
    
    var letter: Character
    
    var body: some View{
        
        Text(letter.description)
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
