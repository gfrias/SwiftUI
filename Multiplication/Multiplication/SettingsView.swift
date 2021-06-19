//
//  NewGameView.swift
//  Multiplication
//
//  Created by Guillermo Frias on 16/06/2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        GeometryReader { gr in
            VStack {
                Form {
                    Section(header: Text("Which table do you want to practice?").font(.headline).padding(.top, 30).padding(.bottom, 5)){
                        Stepper(value: $settings.selectedTable, in: 1...12, step: 1) {
                            Text("Table of \(settings.selectedTable)")
                        }
                    }
                    
                    Section(header: Text("How many questions do you want?").font(.headline).padding(.top, 10).padding(.bottom, 5)){
                        Picker("Select number of questions to answer", selection: $settings.selectedQuestionsIndex) {
                            ForEach(0..<settings.numberOfQuestions.count) { i in
                                if i == settings.numberOfQuestions.count-1 {
                                    Text("All")
                                } else {
                                    Text("\(settings.numberOfQuestions[i])")
                                }
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }.navigationTitle("New Quiz")
                Button(action: {
                    self.settings.showSettings = false
                }, label: {
                    Text("START!").padding(.horizontal, 20).frame(minWidth: 0, idealWidth: gr.size.width-20, maxWidth: gr.size.width-20, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.accentColor).foregroundColor(.white).font(.title3.bold()).clipShape(RoundedRectangle(cornerRadius: 20))
                })
            }
        }
    }
}


struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(GameSettings())
    }
}
