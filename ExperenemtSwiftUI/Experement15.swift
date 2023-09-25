//
//  Experement15.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 19.09.2023.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: Double

    var animatableData: Double {
        get {insetAmount}
        set {insetAmount = newValue}
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
}


struct Checkerboard: Shape {
    var rows: Int
    var columns: Int

    var animatableData: AnimatablePair<Double, Double> { // stores two values, Double and Double
        get {
            AnimatablePair(Double(rows), Double(columns)) // Type conversion. Our rows and columns are ints and are now being converted to doubles
        }


        set {
            rows = Int(newValue.first) // Converts the data back to an int before passing in the value
            columns = Int(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let rowSize = rect.height / Double(rows) // A row is the max height divided by the amount of rows we specify
        let columnsize = rect.width / Double(columns)  // A column is the max width divided by the amount of colums we specify

        for row in 0..<rows { // Loop through rows
            for column in 0..<columns {  // Loop through columns
                if (row + column).isMultiple(of: 2) { // If the result is a multiple of 2
                    let startX = columnsize * Double(column) // Specifies how the rows and columns are drawn from the start position
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnsize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct Experement15: View {
    @State private var amount = 0.0

    @State private var amount1 = 0.0

    @State private var insetAmount = 150.0

    @State private var rows = 4
        @State private var columns = 4

    var body: some View {
        ScrollView(.vertical){

                VStack {
                    ZStack {
                        Circle()
                            .fill(Color(red: 1, green: 0, blue: 0))
                            .frame(width: 200 * amount)
                            .offset(x: -50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(Color(red: 0, green: 1, blue: 0))
                            .frame(width: 200 * amount)
                            .offset(x: 50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(Color(red: 0, green: 0, blue: 1))
                            .frame(width: 200 * amount)
                            .blendMode(.screen)

                    }
                    .frame(width: 70, height: 350)

                    Slider(value: $amount)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .ignoresSafeArea()





                VStack {
                    Spacer(minLength: 30)
                      Image("Scissors")
                          .resizable()
                          .scaledToFit()
                          .frame(width: 150, height: 150)
                          .saturation(amount1)
                          .blur(radius: (1 - amount1) * 20)

                      Slider(value: $amount1)
                          .padding()

                  }
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(.green)
                  .ignoresSafeArea()






            VStack {
            Trapezoid(insetAmount: insetAmount)
                       .frame(width: 300, height: 400)
                       .onTapGesture {
                           withAnimation{
                               insetAmount = Double.random(in: 1...50)
                           }
                       }
            }.padding(10)
                .background(.blue)
                .ignoresSafeArea()





            VStack {
            Checkerboard(rows: rows, columns: columns)
                     .onTapGesture {
                         withAnimation(.linear(duration: 5)){
                             rows = 6
                             columns = 16
                         }
                     }
            }.padding(30)
                .background(.red)
                .ignoresSafeArea()
            }
        }

}

struct Experement15_Previews: PreviewProvider {
    static var previews: some View {
        Experement15()
    }
}
