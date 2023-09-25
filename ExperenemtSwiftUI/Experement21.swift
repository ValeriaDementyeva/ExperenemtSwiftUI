//
//  Experement21.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI
struct PushButton: View {
    let title: String
    @Binding var isOn: Bool // @Binding makes it external state, not local state

    var onColors = [Color.green, Color.yellow]
    var offColors = [Color(white: 0.9), Color(white: 0.2)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(
            LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom)
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 1 : 5)
    }
}

struct Experement21: View {
    @AppStorage("notes") private var notes = "" // Warning: AppStorage is backed by UserDefaults which is not designed to store private or confidential data

    @State private var rememberMe = false

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $notes)
                    .navigationTitle("Notes")
                    .padding()

                PushButton(title: "Remember me", isOn: $rememberMe) // We're now passing in the binding and not the value
                Text(rememberMe ? "On" : "Off")

            }
        }
    }
}

struct Experement21_Previews: PreviewProvider {
    static var previews: some View {
        Experement21()
    }
}
