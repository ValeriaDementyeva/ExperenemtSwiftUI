//
//  Experement11.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 19.09.2023.
//

import SwiftUI

struct Experement11: View {
    let layout = [ // create layout for the LazyVGrid or LazyHGrid
        GridItem(.adaptive(minimum: 80, maximum: 120)) // Sets an adaptive grid with minimum and maximum size specified. This is great as it scales depending on the device and the available screenspace on that device.
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80))
    ]

    var body: some View {
        ScrollView(.horizontal) { // you can specify horizontal or vertical and change Lazy Grid and colums/rows depending on your choice
            LazyHGrid(rows: layout) { // LazyVGrid and LazyHGrid lazy load views as they're scrolled in, so as to not use unnecessary system resources.
                ForEach(0..<101) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct Experement11_Previews: PreviewProvider {
    static var previews: some View {
        Experement11()
    }
}
