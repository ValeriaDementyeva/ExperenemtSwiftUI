//
//  Bookworm.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import SwiftUI
@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController() // instance of the DataController class
    var body: some Scene {
        WindowGroup {
            GeneralView22()
                .environment(\.managedObjectContext, dataController.container.viewContext) // We add the DataController to our SwiftUI environment. A managedObjectContext is essentially the live version of your data, which exists in memory until you actually write it to the disk/storage.
        }
    }
}
