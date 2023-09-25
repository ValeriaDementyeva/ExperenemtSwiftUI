//
//  Experement10.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 19.09.2023.
//

import SwiftUI


//struct Experement10: View {
//    var body: some View {
//        NavigationView {
//            List(0..<20) { row in
//                NavigationLink { // used to show a new view with details that relates to what the user selected. A sheet, for example, is used to show unrelated content, like settings or a compose window.
//                    Text("Detail \(row)")
//                } label: {
//                    Text("Row \(row)")
//                }
//                .navigationTitle("SwiftUI")
//            }
//        }
//
//    }
//        VStack {
//            GeometryReader { geo in
//                Image("black-sands")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: geo.size.width * 0.8) // the multiplication stands for the percentage, in this case 80 percent. 1.0 would be 100 percent.
//                    .frame(width: geo.size.width, height: geo.size.height) // this frame will perfectly align the image to the center
//            }
//        }
//    }
//}

struct Users: Codable { // Used to show how the JSON in the ContentView translates to a Swift struct. The structs must match the JSON string.
    let name: String
    let address: Address
}

struct Address: Codable { // Used to show how the JSON in the ContentView translates to a Swift struct. The structs must match the JSON string.
    let street: String
    let city: String
}


struct Experement10: View {
    var body: some View {
        Button("Decode JSON") { // multi line String with example JSON, containing a name and a dictionary for Address
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                "street": "555, Taylor Swift Avenue",
                "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)

            if let user = try? JSONDecoder().decode(Users.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct Experement10_Previews: PreviewProvider {
    static var previews: some View {
        Experement10()
    }
}
