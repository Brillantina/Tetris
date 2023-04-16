//
//  TetrisApp.swift
//  Tetris
//
//  Created by Rita Marrano on 15/04/23.
//

import SwiftUI

@main
struct TetrisApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GameView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
