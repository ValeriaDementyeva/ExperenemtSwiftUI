//
//  Experement6.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct Experement6: View {

     @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap") // Reads the tapCount back from UserDefaults. It takes a few seconds for the app to write this to permanent storage, so data might not be saved if the app is closed very quickly after the value has updated. It might not have been written to storage.

     var body: some View {
         Button("Tap count: \(tapCount)") {
             tapCount += 1
             UserDefaults.standard.set(tapCount, forKey: "Tap") // We create UserDefaults and put in our tapCount. We assign tapCount to a key named "Tap".
         }
     }

//    @AppStorage("tapCount") private var tapCount = 0
//
//    var body: some View {
//        Button("Tap count: \(tapCount)") {
//            tapCount += 1
//        }
//    }
}

struct Experement6_Previews: PreviewProvider {
    static var previews: some View {
        Experement6()
    }
}
