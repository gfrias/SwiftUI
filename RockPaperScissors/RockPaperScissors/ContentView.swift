//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Guillermo Frias on 03/06/2021.
//

import SwiftUI

struct ContentView: View {
    static let moves = [Move("Rock", "oval", Color.red),
                 Move("Paper", "paperplane", Color.yellow),
                 Move("Scissors", "scissors", Color.green)]
    
    @State private var appChoice = pickChoice()
    @State private var displayAlert = false
    @State private var shouldWin = true
    
    @State private var score = 0
    
    var body: some View {
        VStack(spacing:0) {
            ForEach(0..<ContentView.moves.count) {i in
                Button(action: {
                    self.shouldWin = (i == (appChoice+1) % 3)
                    if self.shouldWin {
                        self.score += 1
                    }
                    self.displayAlert = true
                }, label: {
                    ButtonLabel(move: ContentView.moves[i])
                })
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .alert(isPresented: $displayAlert) {
            shouldWin ? scoreAlert("You won", "Your score so far is", "Continue") {
                self.appChoice = ContentView.pickChoice()
            }:
            scoreAlert("You lost", "Your final score is", "Restart") {
                self.appChoice = ContentView.pickChoice()
                self.score = 0
            }
        }
    }
    
    func scoreAlert(_ title: String, _ message: String, _ button:String, _ dismissAction: @escaping () -> Void) -> Alert {
        Alert(title: Text(title), message: Text("\(message) \(score)"), dismissButton: .default(Text(button)) {
            dismissAction()
        })
    }
    
    static func pickChoice() -> Int {
        let choice = Int.random(in: 0..<3)
        print("picking choice \(moves[choice].title)")
        return choice
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
