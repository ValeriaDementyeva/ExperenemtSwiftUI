//
//  GeneralView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct GeneralView: View {
    @StateObject var expenses = Expenses() // create a new instance of our Expenses class
        @State private var showingAddExpense = false // Used to track whether our sheet containing our AddView view should be sown or not

        var body: some View {
            NavigationView {
                List {
                    ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)

                    ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems)
                }
                .navigationTitle("iExpense")
                .toolbar{
                    Button {
                        showingAddExpense = true // If the button is pressed, a sheet is presented with our AddView view
                    } label: {
                        Image(systemName: "plus")
                    }
                }

                .sheet(isPresented: $showingAddExpense) { // presents a sheet when showingAddExpense = true
                    AddView(expenses: expenses) // shows our AddView view and passes in our instance of the expenses class

                }
            }
        }

        func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) { // function used to delete items in our list
            var objectsToDelete = IndexSet()

            for offset in offsets {
                let item = inputArray[offset]

                if let index = expenses.items.firstIndex(of: item) {
                    objectsToDelete.insert(index)
                }
            }

            expenses.items.remove(atOffsets: objectsToDelete)
        }

        func removePersonalItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: expenses.personalItems)
        }

        func removeBusinessItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: expenses.businessItems)
        }
        
    }




struct ExpenseStyle: ViewModifier { // create a struct that follows the ViewModifier protocol
    let expenseItem: ExpenseItem // create an instance of an ExpenseItem

    func body(content: Content) -> some View {
        switch expenseItem.amount { // Switch statement to control which modifiers are shown and when
        case 0..<10:
            content
                .foregroundColor(.green)
        case 10..<100:
            content
                .foregroundColor(.blue)
        default:
            content
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}

extension View { // creates an extension to the View protocol
    func expenseStyle(for expenseItem: ExpenseItem) -> some View {
        modifier(ExpenseStyle(expenseItem: expenseItem))
    }
}




struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
