//
//  ContentView.swift
//  UnitConverter
//
//  Created by Guillermo Frias on 29/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var inputDistance = ""
    
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.feet
    
    let conversions = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet,
                       UnitLength.yards, UnitLength.miles]
    
    var convertedDistance: Double {
        Measurement(value: Double(inputDistance) ?? 0, unit: inputUnit)
                    .converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    HStack {
                        TextField("Enter a distance", text: $inputDistance)
                            .keyboardType(.decimalPad)
                        Picker("", selection: $inputUnit) {
                            ForEach(conversions, id: \.self) {
                                Text("\($0.symbol)")
                            }
                        }
                    }
                }
                Section(header: Text("Output")) {
                    HStack {
                        Text("\(convertedDistance, specifier: "%.9g")")
                        Picker("", selection: $outputUnit) {
                            ForEach(conversions, id: \.self) {
                                Text("\($0.symbol)")
                            }
                        }
                    }
                }
            }.navigationTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
