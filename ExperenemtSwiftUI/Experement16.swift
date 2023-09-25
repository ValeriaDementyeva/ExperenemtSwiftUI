//
//  Experement16.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 19.09.2023.
//

import SwiftUI
struct Arrow: Shape {
func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.midY))
            path.addLine(to: CGPoint(x: 0, y: rect.midY))
            path.closeSubpath()
        }
    }
}

struct Arrow2: Shape {
    var headHeight = 0.5
    var shaftWidth = 0.5

    func path(in rect: CGRect) -> Path {
        let height = rect.height * headHeight // available height multiplied by how high we want the head to be.
        let thickness = rect.width * shaftWidth / 2

        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
        }
    }
}
struct Arrow3: Shape {
    var headHeight = 0.5
    var shaftWidth = 0.5

    var animatableData: Double {
        get { shaftWidth }
        set { shaftWidth = newValue}
    }

    func path(in rect: CGRect) -> Path {
        let height = rect.height * headHeight // available height multiplied by how high we want the head to be.
        let thickness = rect.width * shaftWidth / 2

        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
        }
    }
}

struct Arrow4: Shape {
    var headHeight = 0.5
    var shaftWidth = 0.5

    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(headHeight, shaftWidth) }
        set {
            shaftWidth = newValue.first
            headHeight = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        let height = rect.height * headHeight // available height multiplied by how high we want the head to be.
        let thickness = rect.width * shaftWidth / 2

        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    // These variables will function as our UnitPoint. We previously said .top/.bottom. Using these variables make the start and end points customizable.
    var gradientStartX = 0.5
    var gradientStartY = 0.0

    var gradientEndX = 0.5
    var gradientEndY = 1.0

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
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


struct Experement16: View {
    @State private var headHeight = 0.5
       @State private var shaftWidth = 0.5

    @State private var headHeight4 = 0.5
       @State private var shaftWidth4 = 0.5

    @State private var colorCycle = 0.0
    @State var gradientStartX = 0.5
    @State var gradientStartY = 0.0
    @State var gradientEndX = 0.5
    @State var gradientEndY = 1.0

    var body: some View {
        ScrollView{
            VStack{
                Arrow()
                    .fill(.blue)
                    .padding(10)
                    .frame(width: 300, height: 300)

                Arrow2()
                    .fill(.red)
                    .padding(10)
                    .frame(width: 300, height: 300)

                Arrow3(headHeight: headHeight, shaftWidth: shaftWidth)
                    .fill(.green)
                    .padding(10)
                    .frame(width: 300, height: 300)

                Arrow4(headHeight: headHeight4, shaftWidth: shaftWidth4)
                    .fill(.yellow)
                    .onTapGesture {
                        withAnimation {
                            headHeight4 = Double.random(in: 0.2...0.8)
                            shaftWidth4 = Double.random(in: 0.2...0.8)
                        }
                    }
                    .padding(10)
                    .frame(width: 300, height: 300)

                VStack {
                    ColorCyclingRectangle(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                        .frame(width: 300, height: 300)

                    HStack {
                        Text("Color")
                        Slider(value: $colorCycle)
                    }

                    HStack {
                        Text("Start X")
                        Slider(value: $gradientStartX)
                    }

                    HStack {
                        Text("Start Y")
                        Slider(value: $gradientStartY)
                    }

                    HStack {
                        Text("End X")
                        Slider(value: $gradientEndX)
                    }

                    HStack {
                        Text("End Y")
                        Slider(value: $gradientEndY)
                    }
                }
                .padding(10)
            }

        }
    }
}

struct Experement16_Previews: PreviewProvider {
    static var previews: some View {
        Experement16()
    }
}
