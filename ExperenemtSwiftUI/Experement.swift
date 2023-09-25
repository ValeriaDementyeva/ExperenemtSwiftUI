//
//  ContentView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI




struct Experement : View {

    @State private var checkAmount = 0.0
       @State private var numberOfPeople = 2
       @State private var tipPercentage = 20
       @FocusState private var amountIsFocused: Bool

       let tipPercentages = Array(1..<101)
   //    func currencyFormatter() -> FloatingPointFormatStyle<Double>.Currency {
   //        .currency(code: Locale.current.currencyCode ?? "EUR")
   //    }

       var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
           let currencyCode = Locale.current.currencyCode ?? "EUR"
           return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
       }

       var totalPerPerson: Double {
           // Calculate total per person
           let peopleCount = Double (numberOfPeople + 2)
           let tipSelection = Double (tipPercentage)

           let tipValue = checkAmount / 100 * tipSelection
           let grandTotal = checkAmount + tipValue
           let amountPerPerson = grandTotal / peopleCount

           return amountPerPerson
       }

       var grandTotal: Double {
           let tipSelection = Double (tipPercentage)

           let tipValue = checkAmount / 100 * tipSelection
           let grandTotal = checkAmount + tipValue

           return grandTotal
       }

       var body: some View {
           NavigationView {
               Form {
                   Section {
                       TextField("Amount", value: $checkAmount, format:
                               .currency(code: Locale.current.currencyCode ?? "USD"))
                               .keyboardType(.decimalPad)
                               .focused($amountIsFocused)

                       Picker("Number of people", selection: $numberOfPeople) {
                           ForEach(2..<100) {
                               Text("\($0) people")
                           }
                       }
                   }

                   Section {
                       Picker("Tip percentage", selection: $tipPercentage) {
                           ForEach(tipPercentages, id: \.self) {
                               Text($0, format: .percent)
                           }
                       }

                       .pickerStyle(.automatic)
                   } header: {
                       Text("Tip percentage")
                   }

                   Section {
                       Text(grandTotal, format: currencyFormatter)
                   } header: {
                       Text("Grand total")
                   }

                   Section {
                       Text(totalPerPerson, format: currencyFormatter)
                   } header: {
                       Text("Amount per person")
                   }

               }

               .navigationTitle("WeSplit")
               .toolbar{
                   ToolbarItemGroup(placement: .keyboard) {
                       Spacer()

                       Button("Done") {
                           amountIsFocused = false
                       }
                   }
               }
           }
       }
    }




struct Experement_Previews: PreviewProvider {
    static var previews: some View {
        Experement()
    }
}

