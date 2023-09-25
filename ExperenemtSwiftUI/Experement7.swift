//
//  Experement&.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI
struct User: Codable {
    let firstName: String
    let lastName: String
}

//сохраняю данные в формате джейсон 
struct Experement7: View {

        @State private var user = User(firstName: "Taylor", lastName: "Swift")

        var body: some View {
            Button("Save User") {
                let encoder = JSONEncoder() // Create an instance of a JSON encoder. If you want to unarchive, you can use JSONDecoder()

                if let data = try? encoder.encode(user) { // data is a new datatype called Data (with a capital D). This might throw errors, so we have to use try?
                    UserDefaults.standard.set(data, forKey: "UserData") // Stores our user, which has been encoded as Data, in UserDefaults
                }
            }
        }
}

struct Experement7Previews: PreviewProvider {
    static var previews: some View {
        Experement7()
    }
}
