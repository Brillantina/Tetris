//
//  GameViewModel.swift
//  Tetris
//
//  Created by Rita Marrano on 15/04/23.
//

import Foundation
import SwiftUI


final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var gameLetter: Character = " "

    @Published var score: Int = 0
    @Published var gameLetters : [Character] = []
    
    
    
    init() {

        gameLetters = randomAString()
        
    }

    



    
    
    func randomAString() ->[Character]{

//        let vocalCharacters: [Character] = ["A", "E", "I", "O", "U", "Y"]


        let consonantCharacters: [Character] = ["B", "C", "D"  , "L", "F", "G", "H", "M", "N", "P", "Q", "R", "S","T","U","V","Z","W","K","A","E","I","O","U","Y"]


        var letter: Character = " "
        
        for _ in 0...5{
           
            letter=consonantCharacters.randomElement() ?? " "
            print(letter)
            
        
            gameLetters.append(letter)
            print(gameLetters)

        }
        return gameLetters
    }

    
    func processPlayerMove(for position: Int, letter: Character){
        
        if isSquareOccupied(in: moves, forIndex: position){ return }
        
        
        moves[position] = Move(player: .human, boardIndex: position, letter: letter)
        
        //check if win
        let (win, winIndices) = checkWinConditions(for: .human, in: moves)
        if win, let indices = winIndices {
            for index in indices {
                removeMove(forIndex: index, from: &moves)
            }
        }
        
        if checkForDraw(in: moves){
            resetGame()
           
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){ [self] in //senza self in da un sacco di errori
            
            let computerPositions = determineComputerCheckPosition(in: moves)
            moves[computerPositions] = Move(player: .computer, boardIndex: computerPositions, letter: letter)
            isGameBoardDisabled = false
            
            if checkForDraw(in: moves){
                resetGame()
                
            }
        }
    }
    
    
    
    func isSquareOccupied( in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    

    
    

    func removeMove(forIndex index: Int, from moves: inout [Move?]) {
        for i in 0..<moves.count {
            if let move = moves[i], move.boardIndex == index {
                moves[i] = nil
                break
            }
        }
    }


    
    func checkWinConditions(for player: Player, in moves: [Move?]) -> (Bool, [Int]?) {
        
        let indices = moves.enumerated().compactMap { $0.element?.boardIndex }
        let letterCount:[Character: Int] = indices.reduce(into: [:]) { counts, index in
            if let letter = moves[index]?.letter {
                counts[letter, default: 0] += 1
            }
        }
        let winPatterns: Set<Set<Character>> = [ ["A","C","E"],
                                                 ["E","R","E"],
                                                 ["E","R","A"],
                                                 ["E","C","O"],
                                                 ["I","C","E"],
                                                 ["W","I","N"],
                                                 ["N","I","L"],
                                                 ["N","U","T"],
                                                 ["C","A","T"],
                                                 ["C","A","R"],
                                                 ["B","A","R"],
                                                 ["B","U","A"]]
//
//        return winPatterns.contains {
//            $0.allSatisfy { letterCount[$0, default: 0] > 0 && moves[indices.first { index in moves[index]?.boardIndex == index }!]?.player == player }
//            }
        if let winningPattern = winPatterns.first(where: { pattern in
            pattern.allSatisfy { letterCount[$0, default: 0] > 0 && moves[indices.first { index in moves[index]?.boardIndex == index }!]?.player == player }
        }) {
            let boardIndices = winningPattern.compactMap { letter in
                indices.first { index in moves[index]?.letter == letter }
            }
            return (true, boardIndices)
        }
        
        return (false, nil)

    }
    
    
    
    
    func determineComputerCheckPosition( in moves: [Move?]) -> Int {
        
        let winPatterns: Set<Set<Character>> = [ ["A","C","E"],
                                                 ["E","R","E"],
                                                 ["E","R","A"],
                                                 ["E","C","O"],
                                                 ["I","C","E"],
                                                 ["W","I","N"],
                                                 ["N","I","L"],
                                                 ["N","U","T"],
                                                 ["C","A","T"],
                                                 ["C","A","R"],
                                                 ["B","A","R"]
        ]
        
        //IF AI CAN WIN IT WILL DO IT
        let computerMoves = moves.compactMap{$0}.filter({ $0.player == .computer })
        let computerPositions = Set(computerMoves.map{$0.letter})
        
        //        // Check each row for a win pattern
        //        for (rowIndex, row) in board.enumerated() {
        //            if winPatterns.contains(Set(row)) {
        //                return nil
        //            }
        //        }
        
        print(computerPositions)
        
        
        let humanMoves = moves.compactMap{$0}.filter({ $0.player == .human })
        let humanPositions = Set(humanMoves.map{$0.letter})



        
        //IF AI CAN'T BLOCK THEN WILL TAKE A MIDDLE SQUARE
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return ((centerSquare) )
        }
        
        //IF AI CAN'T TAKE A MIDDLE SQUARE FO FOR A RANDOM AVAIBLE ONE INSTEAD
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
        
        
    }
    


    
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{$0}.count == 9
    }
    
    func resetGame(){
        moves = Array(repeating: nil, count: 9)
        gameLetters.removeAll()
        gameLetters = randomAString()
    }
    

}
