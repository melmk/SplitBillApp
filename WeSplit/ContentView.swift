//
//  ContentView.swift
//  WeSplit
//
//  Created by Melissa Kwong on 25/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var  checkAmount = 0.0
    @State private  var numberofPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberofPeople + 2)
        let tipSelection = Double(tipPercentage)

        return (checkAmount/100 * tipSelection + checkAmount)/peopleCount
    }
    
    var totalAmount: Double {
        checkAmount/100 * Double(tipPercentage) + checkAmount
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberofPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Enter tip percentage")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Amount including tip")
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
