//
//  AddView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses // Tells SwiftUI that our view requires an instant of the Expenses class to be passed in to read/modify. We are NOT creating a new instance, we are just passing one in that already exists.
    @Environment(\.dismiss) var dismiss // dismisses the view when it is called

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .localCurrency)
                    .keyboardType(.decimalPad) // Used to get the number specific keyboard
            }

            .navigationTitle("Add new expense")
            .toolbar{
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item) // We create an item and bind the values of our form to the item, then add that item to our list of items in the instance of the expenses class.
                    dismiss() // closes the view when the save button is pressed
                }
            }
        }
    }
}


extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

