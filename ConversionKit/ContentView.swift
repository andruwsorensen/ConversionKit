//
//  ContentView.swift
//  ConversionKit
//
//  Created by Andruw Sorensen on 1/11/24.
//

import SwiftUI

struct ContentView: View {
    // Could have done all of this with the Measurement type
    @State private var initialTemp = "Fahrenheit"
    @State private var conversionTemp = "Celsius"
    @State private var firstTemp = 0.0
    @FocusState private var tempIsFocused: Bool
    
    var result: Double {
        var secondTemp: Double = firstTemp
        if initialTemp == conversionTemp { return firstTemp }
        // Converting the temp to Celsius for easier conversion later
        if initialTemp == "Fahrenheit" {
            secondTemp = (firstTemp - 32) * 5 / 9
        } else if initialTemp == "Kelvin" {
            secondTemp = firstTemp - 273.15
        }
        
        if conversionTemp == "Celsius" {
            return secondTemp
        } else if conversionTemp == "Kelvin" {
            return secondTemp + 273.15
        } else if conversionTemp == "Fahrenheit" {
            return secondTemp * 9 / 5 + 32
        }
        
        return 0.0
    }
    
    let tempTypes = ["Celsius", "Fahrenheit", "Kelvin"]

    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section("Initial temperature") {
                        Picker("Temp Types", selection: $initialTemp) {
                            ForEach(tempTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section("Convert to") {
                        Picker("Temp Types", selection: $conversionTemp) {
                            ForEach(tempTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section {
                        HStack {
                            TextField("Initial Temp", value: $firstTemp, format: .number)
                                .keyboardType(.decimalPad)
                                .focused($tempIsFocused)
                            Spacer()
                            Text(result, format: .number)
                        }
                    }
                }
                .navigationTitle("ConversionKit")
                .toolbar {
                    if tempIsFocused {
                        Button("Done") {
                            tempIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
