//
//  Experement3.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct Experement3: View {

        let letters = Array("Hello SwiftUI")
        @State private var enabled = false
        @State private var dragAmount = CGSize.zero

        @State private var rotationAmount = 0

        @State private var isShowingBlack = false

        @State private var isShowingRed = false

        var body: some View {
            VStack{
                HStack(spacing: 0) {
                    ForEach(0..<letters.count, id: \.self) { num in
                        Text(String(letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(enabled ? .green : .blue)
                            .offset(dragAmount)
                            .animation(.default.delay(Double(num) / 9), value: dragAmount)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            dragAmount = .zero
                            enabled.toggle()
                        }
                )



                ZStack {
                           Rectangle()
                               .fill(.green)
                               .frame(width: 200, height: 200)

                           if isShowingRed {
                           Rectangle()
                               .fill(.red)
                               .frame(width: 200, height: 200)
                               .transition(.pivot)

                           }
                       }
                       .onTapGesture {
                           withAnimation {
                               isShowingRed.toggle()
                           }
                       }





                Button("Tap me") {
                    withAnimation(.interpolatingSpring(stiffness: 10, damping: 1)) {
                        rotationAmount += 180
                    }
                }
                .padding(50)
                .background(.yellow)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(Double(rotationAmount)), axis: (x: 0, y: 1, z: 0))




                    Button("Tap Me2") {
                        withAnimation {
                            isShowingBlack.toggle()
                        }            }
                    if isShowingBlack {
                        Rectangle()
                            .fill(.black)
                            .frame(width: 200, height: 200)
                            .cornerRadius(30)
                    }





            }
    }
    }

    struct CornerRotateModifier: ViewModifier {
        let amount: Double
        let anchor: UnitPoint

        func body(content: Content) -> some View {
            content
                .rotationEffect(.degrees(amount), anchor: anchor)
                .clipped()
        }
    }

    extension AnyTransition {
        static var pivot: AnyTransition {
            .modifier(
                active: CornerRotateModifier(amount: -130, anchor: .topLeading),
                identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
        }
    }



struct Experement3_Previews: PreviewProvider {
    static var previews: some View {
        Experement3()
    }
}
