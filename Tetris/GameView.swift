//
//  GameView.swift
//  Tetris
//
//  Created by Rita Marrano on 15/04/23.
//
import SwiftUI
import CoreData




struct GameView: View {
    
    @StateObject private var vm = GameViewModel()
    
    
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: vm.columns, spacing: 5){
                    ForEach(0..<9){ i in
                        ZStack{
                            Circle()
                                .foregroundColor(.brown)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                            
                            Image(systemName: vm.moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            
                            vm.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(vm.isGameBoardDisabled)
            .padding()
            .alert(item: $vm.alertItem, content: {alertItem in
                Alert(title: alertItem.title, message:  alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {vm.resetGame() }))
            })
        }
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
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
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
