//
//  Experement12.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 19.09.2023.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // min X is the smallest x value in the rectangle, max the greatest value and mid is the horizontal halfway point
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape { // InsettableShape inherits from the Shape protocol
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0


    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 3 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}


struct Experement12: View {
    var body: some View {
        VStack{


            Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                .strokeBorder(.indigo, lineWidth: 20)

            Triangle()
                .fill(.red)
                .frame(width: 100, height: 100)

            Arc(startAngle: .degrees(0), endAngle: .degrees(300), clockwise: true)
                .stroke(.blue, lineWidth: 20)
                .frame(width: 100, height: 100)

            Circle()
                .strokeBorder(.indigo, lineWidth: 60) // SwiftUI will stroke the inside of the border when using strokeBorder()
        }
    }
}

struct Experement12_Previews: PreviewProvider {
    static var previews: some View {
        Experement12()
    }
}
