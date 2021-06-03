//
//  ButtonLabel.swift
//  RockPaperScissors
//
//  Created by Guillermo Frias on 03/06/2021.
//

import SwiftUI

struct Move {
    let title: String
    let icon: String
    let color: Color
    
    init(_ title: String, _ icon: String, _ color: Color) {
        self.title = title
        self.icon = icon
        self.color = color
    }
}

struct ButtonLabel: View {
    let move:Move
    
    var body: some View {
        ZStack {
            move.color.frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .center)
            Label(
                title: { Text(move.title) },
                icon: { Image(systemName: move.icon) })
        }.font(.title.smallCaps())
        .foregroundColor(.primary)
    }
}


struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(move: Move("Rock", "oval", Color.red))
    }
}
