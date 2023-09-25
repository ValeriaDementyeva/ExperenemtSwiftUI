//
//  Expenses.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

class Expenses: ObservableObject {
    var personalItems: [ExpenseItem] {
            items.filter { $0.type == "Personal" }
        }

        var businessItems: [ExpenseItem] {
            items.filter { $0.type == "Business" }
        }
    
    @Published var items = [ExpenseItem]() { // An array of ExpenseItem
        didSet { // the code within didSet will run any time a change is detected in our ExpenseItem array
            let encoder = JSONEncoder() // create an instance of the JSONEncoder

            if let encoded = try? encoder.encode(items) { // create an encoded variable that will store the encoded items. Try? is used cause it might throw an error
                UserDefaults.standard.set(encoded, forKey: "Items") // Store our encoded items with the key "Items"
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") { // read data from UserDefaults for the key "Items"
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) { // If we can read the data, attempt decoded and convert the data into ExpenseItem.self. .self in this case means that mean an array of ExpenseItems.
                items = decodedItems // the array of ExpenseItem is now an array of ExpenseItem that contains the decodedItems
                return
            }
        }

        items = [] // If code does not run, for example if the data can't be read or there isn't any data to be read, return an empty array instead

    }
}
