//
//  Experement5.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct Experement5: View {
    @State private var numbers = [Int]()
        @State private var currentNumber = 1

        var body: some View {
            NavigationView {
                VStack {
                    List {
                        ForEach(numbers, id: \.self) { // .onDelete can only be called on a ForEach
                            Text("Row \($0)")
                        }

                        .onDelete(perform: removeRows) // Calls onDelete and performs the remvoeRows function
                    }

                    Button("Add Number") {
                        numbers.append(currentNumber) // Each tap on the button adds a new row and increments the current number by 1
                        currentNumber += 1
                    }
                }
                .navigationTitle("onDelete()")
                .toolbar {
                    EditButton() // adds an edit button so rows can quickly be deleted
            }

            }
        }

        func removeRows(at offsets: IndexSet) { // An IndexSet tells us the position of all the items in the ForEach that should be removed.
            numbers.remove(atOffsets: offsets)
        }
}

struct Experement5_Previews: PreviewProvider {
    static var previews: some View {
        Experement5()
    }
}
