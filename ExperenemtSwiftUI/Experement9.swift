//
//  Experement9.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct Experement9: View {
    @State private var sleepAmount = 0.59
    @State private var date = Date()

    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 1...3, step: 0.25)

            DatePicker("Please enter a date", selection: $date, in: Date.now..., displayedComponents: .date).foregroundColor(.blue)

            Text(Date.now, format: .dateTime.hour().minute().day().month().year())

            Text(Date.now.formatted(date: .long, time: .omitted)).foregroundColor(.red)
        }
    }
}

struct Experement9_Previews: PreviewProvider {
    static var previews: some View {
        Experement9()
    }
}
