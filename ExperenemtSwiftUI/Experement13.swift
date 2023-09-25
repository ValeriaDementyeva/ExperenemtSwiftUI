//
//  Experement13.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 19.09.2023.
//

import SwiftUI

struct Flower: Shape {
    var petalOffset = -20.0 // Move 20 points away from the center
    var petalWidth = 100.0 // How wide to make each petal

    func path(in rect: CGRect) -> Path {
        var path = Path() // This path will hold all the petals

        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 20) { // Count in 1/8 of Pi each time
            let rotation = CGAffineTransform(rotationAngle: number) // Rotate the petal by 1/8 of Pi
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2)) // Move the petal. Concatenating is adding this transform to the current transform, so rotate, then move. We want to move the width and height / 2, so halve of our drawing space.

            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2)) // Original petal, untransformed

            let rotatedPetal = originalPetal.applying(position) // rotates the petal by applying the position

            path.addPath(rotatedPetal)
        }

        return path

        // What we've created in this function is a bunch of rotating elipses.
    }
}

struct Experement13: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
            // .stroke(.red, lineWidth: 1)
                .fill(.red, style: FillStyle(eoFill: true, antialiased: true)) //eoFill stands for Even/Odd fill. If Path's overlap, the first will be filled, the second won't, the third will, the fourth won't, etc.

            Text("OffSet")
            Slider(value: $petalWidth, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct Experement13_Previews: PreviewProvider {
    static var previews: some View {
        Experement13()
    }
}
