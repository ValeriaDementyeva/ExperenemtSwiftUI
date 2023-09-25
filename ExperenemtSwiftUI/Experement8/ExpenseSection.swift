//
//  ExpenseSection.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct ExpenseSection: View {
    let title: String
       let expenses: [ExpenseItem]
       let deleteItems: (IndexSet) -> Void

       var body: some View {
           Section(title) {
               ForEach(expenses) { item in // Loop through our items in the expenses class instance
                   HStack {
                       VStack(alignment: .leading) {
                           Text(item.name)
                               .font(.headline)
                           Text(item.type)
                       }

                       Spacer()

                       Text(item.amount, format: .localCurrency)
                           .expenseStyle(for: item)
                       //                            .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .indigo : .red)
                       //                            .font(item.amount < 10 ? .title3 : item.amount < 100 ? .title2 : .title)

                   }
               }
               .onDelete(perform: deleteItems) // Used to delete a row
           }
       }
   }


struct ExpenseSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSection(title: "Example", expenses: [], deleteItems: { _ in })
    }
}
