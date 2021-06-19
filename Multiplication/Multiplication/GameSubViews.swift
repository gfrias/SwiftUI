//
//  GameSubViews.swift
//  Multiplication
//
//  Created by Guillermo Frias on 19/06/2021.
//

import SwiftUI

struct StepsView: View {
    let step: Int
    let totalQuestions: Int
    
    var body: some View {
        ProgressView(value: Double(step), total: Double(totalQuestions)).progressViewStyle(LinearProgressViewStyle(tint: Color.white))
    }
}

struct QuestionView: View {
    let question: Question
    
    var body: some View {
        Text("\(question.m1) x \(question.m2) = ?").font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white)
    }
}

struct TextNumberView: View {
    let number: Int
    let color: Color
    
    var body: some View {
        Text("\(number)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.medium).padding(40)
            .foregroundColor(.black).background(color)
            .clipShape(Circle()).overlay(Circle().stroke(Color.black, lineWidth: 1)).shadow(color:. black, radius: 2)
    }
}

struct EndView: View {
    @EnvironmentObject var settings: GameSettings
    let correctAnswers: Int
    let totalQuestions: Int
    
    var body: some View {
        Text("You got \(correctAnswers)/\(totalQuestions) right").font(.largeTitle).foregroundColor(.white)
        Button(action: {
            self.settings.showSettings = true
        }, label: {
            Label("Play again", systemImage: "arrow.clockwise.circle.fill").font(.title).foregroundColor(.white)
        })
    }
}
