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
    @Published var alertItem: AlertItems?
    
    
    
    
    
    func processPlayerMove(for position: Int){
        
        if isSquareOccupied(in: moves, forIndex: position){ return }
        
        moves[position] = Move(player: .human, boardIndex: position)
        
        
        if (checkWinConditions(for: .human, in: moves)) {
            alertItem = AlertContent.humanWin
    
        }

        if checkForDraw(in: moves){
            alertItem = AlertContent.draw
            return
        }
        isGameBoardDisabled = true
        
        //check if win
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){ [self] in //senza self in da un sacco di errori
            
            let computerPositions = determineComputerCheckPosition(in: moves)
            moves[computerPositions] = Move(player: .computer, boardIndex: computerPositions)
            isGameBoardDisabled = false
            
            if (checkWinConditions(for: .computer, in: moves)) {
                alertItem = AlertContent.computerWin
            }
            
            if checkForDraw(in: moves){
                alertItem = AlertContent.draw
                return
            }
        }
    }
    
    
    
    func isSquareOccupied( in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    

    
    
//    func determineComputerPosition(in moves : [Move?])-> Int {
//        
//        var possiblePositions = Int.random(in: 0..<9)
//        
//        while isSquareOccupied(in: moves, forIndex: possiblePositions){
//            possiblePositions = Int.random(in: 0..<9)
//        }
//        return possiblePositions
//    }

    
    func checkWinConditions(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [ [0,1,2],
                                           [3,4,5],
                                           [6,7,8],
                                           [0,3,6],
                                           [1,4,7],
                                           [2,5,8],
                                           [0,4,8],
                                           [2,4,6]]

        let playerMoves = moves.compactMap{$0}.filter{$0.player == player}
        let playerPositions = Set(playerMoves.map{
            $0.boardIndex
        })

        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {return true}

        return false
    }
    
    
    
    
    
    func determineComputerCheckPosition( in moves: [Move?]) -> Int {
        
        let winPatterns: Set<Set<Int>> = [ [0,1,2],
                                           [3,4,5],
                                           [6,7,8],
                                           [0,3,6],
                                           [1,4,7],
                                           [2,5,8],
                                           [0,4,8],
                                           [2,4,6]]
        
        //IF AI CAN WIN IT WILL DO IT
        let computerMoves = moves.compactMap{$0}.filter({ $0.player == .computer })
        let computerPositions = Set(computerMoves.map{$0.boardIndex})
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvaible = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaible {return (winPositions.first! ) }
            }
        }
        
        //IF AI CAN'T WIN THEN WILL BLOCK
        
        let humanMoves = moves.compactMap{$0}.filter({ $0.player == .human })
        let humanPositions = Set(humanMoves.map{$0.boardIndex})
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvaible = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaible {return (winPositions.first! ) }
            }
        }
        
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
    }
}
