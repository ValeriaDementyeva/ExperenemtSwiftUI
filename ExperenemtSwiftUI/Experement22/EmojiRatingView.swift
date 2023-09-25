//
//  EmojiRatingView.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI

struct EmojiRatingView: View {

        let rating: Int16

        var body: some View {
            switch rating {
            case 0:
                return Text("\u{1F92E}")
            case 1:
                return Text("\u{1F615}")
            case 2:
                return Text("\u{1F610}")
            case 3:
                return Text("\u{1F60A}")
            default:
                return Text("\u{1F929}")
            }
        }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 5)
    }
}
