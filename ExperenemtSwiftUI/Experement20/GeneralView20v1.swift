//
//  GeneralView20.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI


struct GeneralView20v1: View {
    @Environment(\.managedObjectContext) var moc
        @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student> // We're saying: make a new FetchRequest with no sorting, put in a property called students with a type of FetchedResults Student.

        var body: some View {
            VStack {
                List(students) { student in
                    Text(student.name ?? "Unknown") // Optionals in Core Data mean something different than optionals in SwiftUI, despite having the same name. Core Data always returns optionals, even if marked as required. You have to use nil coalescing everywhere, but we'll learn a better workaround in the future.
                }

                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement() ?? "Unknown"
                    let chosenLastName = lastNames.randomElement() ?? "Unknown"

                    let student = Student(context: moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"

                    try? moc.save() // This can throw an error, but we don't do any error handling here because we've hardcoded everything above
                }
            }
        }
}

struct GeneralView20_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView20v1()
    }
}
