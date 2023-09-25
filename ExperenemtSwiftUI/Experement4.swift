//
//  Experement4.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI



    struct SecondView: View {
        @Environment(\.dismiss) var dismiss

        let name: String // our view must have a name property passed in

        var body: some View {
            VStack {
                Text("Hello, \(name)")
                    .padding(20)
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }

struct Experement4: View {

        @State private var showingSheet = false

        var body: some View {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) { // present the sheet
                SecondView(name: "Darryl")
            }
        }
    }


struct Experement4_Previews: PreviewProvider {
    static var previews: some View {
        Experement4()
    }
}
