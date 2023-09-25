//
//  RatingView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI

struct RatingView: View {

    @Binding var rating: Int

    var label = ""

    var offImage: Image? // will use the same as on image
    var onImage = Image(systemName: "star.fill") // a filled star image

    var offColor = Color.gray // gray stars when not highlighted
    var onColor = Color.yellow // yellow stars when highlighted

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<6, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }

    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(5))
    }
}
