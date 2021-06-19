//
//  MultiplicationApp.swift
//  Multiplication
//
//  Created by Guillermo Frias on 14/06/2021.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var selectedTable = 5
    @Published var selectedQuestionsIndex = 2
    @Published var showSettings = true
    
    let numberOfQuestions = [2,5,7,10]
}

@main
struct MultiplicationApp: App {
    @StateObject var settings = GameSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(settings)
        }
    }
}
