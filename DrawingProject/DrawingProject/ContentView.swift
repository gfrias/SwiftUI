//
//  ContentView.swift
//  DrawingProject
//
//  Created by Guillermo Frias on 09/07/2021.
//

import SwiftUI

struct Arrow: Shape {
    var thickness: CGFloat
    var animatableData: CGFloat {
        get {
            thickness
        }
        set {
            self.thickness = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let size: CGFloat = 40
        
        var linePath = Path()
        linePath.move(to: CGPoint(x: rect.midX-thickness, y: size))
        linePath.addLine(to: CGPoint(x: rect.midX-thickness, y: rect.maxY))
        linePath.addLine(to: CGPoint(x: rect.midX+thickness, y: rect.maxY))
        linePath.addLine(to: CGPoint(x: rect.midX+thickness, y: size))
        linePath.addLine(to: CGPoint(x: rect.midX-thickness, y: size))
        
        var trianglePath = Path()
        trianglePath.move(to: CGPoint(x: rect.midX, y: 0))
        trianglePath.addLine(to: CGPoint(x: rect.midX-size, y: size))
        trianglePath.addLine(to: CGPoint(x: rect.midX+size, y: size))
        trianglePath.addLine(to: CGPoint(x: rect.midX, y: 0))
        
        linePath.addPath(trianglePath)
        
        return linePath
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

//struct ContentView: View {
//    @State private var thickness = 1.0
//
//    var body: some View {
//        VStack {
//            Arrow(thickness: CGFloat(thickness))
//            .fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
//            Group {
//                Text("Thickness")
//                Slider(value: $thickness, in: 0.0...5.0).padding([.horizontal, .bottom])
//                Button("test") {
//                    withAnimation {
//                        self.thickness += self.thickness
//                    }
//                }
//            }
//        }
//    }
//}
struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
