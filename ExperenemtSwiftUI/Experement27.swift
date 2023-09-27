//
//  Experement27.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 27.09.2023.
//

import SwiftUI

struct Experement27: View {
    @State private var blurAmount = 0.0
    @State private var showingConfirmation = false
      @State private var backgroundColor = Color.white

    var body: some View {
        VStack {
                  Text("Hello, World!")
                      .blur(radius: blurAmount)
                      .frame(width: 300, height: 300)
                                 .background(backgroundColor)
                                 .onTapGesture {
                                     showingConfirmation = true
                                 }
                                 .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                                     Button("Red") { backgroundColor = .red }
                                     Button("Green") { backgroundColor = .green }
                                     Button("Blue") { backgroundColor = .blue }
                                     Button("Cancel", role: .cancel) { }
                                 } message: {
                                     Text("Select a new color")
                                 }

                  Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { newValue in
                                   print("New value is \(newValue)")
                               }

                  Button("Random Blur") {
                      blurAmount = Double.random(in: 0...20)
                  }
              }
          }
}

struct Experement27_Previews: PreviewProvider {
    static var previews: some View {
        Experement27()
    }
}
