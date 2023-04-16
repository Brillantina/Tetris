//
//  Alerts.swift
//  Tetris
//
//  Created by Rita Marrano on 15/04/23.
//

import Foundation
import SwiftUI

struct AlertItems: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContent {
   static let humanWin = AlertItems(title: Text("Bra'!"), message: Text("Sei riuscito a battere un bot che funziona male"), buttonTitle: Text("Retry"))
    
   static let computerWin = AlertItems(title: Text(". . ."), message: Text("Non sei riuscito a battere un bot che funziona male"), buttonTitle: Text("Retry"))
    
    static let draw = AlertItems(title: Text(". . ."), message: Text(". . ."), buttonTitle: Text("Retry"))
}
