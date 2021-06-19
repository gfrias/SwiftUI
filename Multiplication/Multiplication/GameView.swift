//
//  GameView.swift
//  Multiplication
//
//  Created by Guillermo Frias on 18/06/2021.
//

import SwiftUI

enum Status {
    case ask
    case show
    case pause
    case end
}

struct GameView: View {
    @EnvironmentObject var settings: GameSettings
    
    @State private var selectedNumber: Int?
    @State private var step = 0
    @State private var correctAnswers = 0
    
    @State private var status = Status.ask
    
    let questions: [Question]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing:20){
                if status == .ask || status == .show {
                    StepsView(step: step, totalQuestions: questions.count)
                    Spacer()
                    QuestionView(question: questions[step])
                }
                Spacer()
                
                switch(status) {
                case .ask:
                    ForEach(questions[step].options, id: \.self) { number in
                        Button(action: {
                            self.selectedNumber = number
                            self.correctAnswers += isCorrect(number: number) ? 1: 0
                            self.status = .show
                        }) {
                            TextNumberView(number: number, color: .yellow)
                        }
                    }
                case .show:
                    ForEach(questions[step].options, id: \.self) { number in
                        TextNumberView(number: number, color: buttonColor(number))
                    }.onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            self.status = (step+1 == questions.count) ? .end : .pause
                        }
                    }
                case .pause:
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white)).scaleEffect(2).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.step += 1
                            self.status = .ask
                        }
                    }
                case .end:
                    EndView(correctAnswers: self.correctAnswers,
                            totalQuestions: self.questions.count)
                    .onAppear() {
                        self.step += 1
                    }
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
    
    func isCorrect(number: Int) -> Bool {
        questions[step].m1 * questions[step].m2 == number
    }
    
    func buttonColor(_ number: Int) -> Color {
        guard let selectedNumber = selectedNumber, number == selectedNumber else {
            return Color.yellow
        }
        
        return isCorrect(number: number) ? Color.green : Color.red
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(questions: ContentView.sampleQuestions())
            .environmentObject(GameSettings())
    }
}
