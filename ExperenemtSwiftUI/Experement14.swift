//
//  Experement14.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 19.09.2023.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 150

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                    ),
                    lineWidth: 2
                )
            }
        }
        .drawingGroup() // This modifier tells SwiftUI to render the content of the view into an off screen image, before putting it back on the screen as a single piece of rendered output. Behind the scenes, this is not powered by Core Animation. Instead, it's powered by Apple's graphics API Metal.
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount // If we are circle 25 of 100, for example, that is our targetHue

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}



struct Experement14: View {

        @State private var colorCycle = 0.0

        var body: some View {
            VStack {
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 350, height: 350)

                Slider(value: $colorCycle)

            Text("Hello, world!")
                .frame(width: 300, height: 300)
                .border(ImagePaint(image: Image("Scissors"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 70)
        .background(.gray)
            }
    }
}

struct Experement14_Previews: PreviewProvider {
    static var previews: some View {
        Experement14()
    }
}
