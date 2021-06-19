//
//  ContentView.swift
//  Multiplication
//
//  Created by Guillermo Frias on 14/06/2021.
//

import SwiftUI

struct Question {
    let m1: Int
    let m2: Int
    let options: [Int]
}

struct ContentView: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        NavigationView {
            if settings.showSettings {
                SettingsView()
            } else {
                GameView(questions: buildQuestions())
            }
        }
    }
    
    func buildQuestions() -> [Question] {
        let table = settings.selectedTable
        let totalQuestions = settings.numberOfQuestions[settings.selectedQuestionsIndex]
        
        let values = (1 ... 10).shuffled()[0...totalQuestions-1]
        
        return values.map { i in
            var options = [table*i]
            while options.count < 3 {
                let r = Int.random(in: 1 ... 10)*table
                if !options.contains(r) {
                    options.append(r)
                }
            }
            
            return Question(m1: table,
                            m2: i,
                            options: options.shuffled())
        }
    }
    
    static func sampleQuestions() -> [Question] {
        [Question(m1: 2, m2: 3, options: [2,6,5]), Question(m1: 3, m2: 4, options: [12,5,2])]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameSettings())
    }
}


