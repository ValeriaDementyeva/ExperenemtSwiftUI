//
//  BookwormApp.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI

//@main

struct BookwormApp1: App {
    @StateObject private var dataController = DataController1() // instance of the DataController class
    var body: some Scene {
        WindowGroup {
            GeneralView20v1()
                .environment(\.managedObjectContext, dataController.container.viewContext) // We add the DataController to our SwiftUI environment. A managedObjectContext is essentially the live version of your data, which exists in memory until you actually write it to the disk/storage.
        }
    }
}
