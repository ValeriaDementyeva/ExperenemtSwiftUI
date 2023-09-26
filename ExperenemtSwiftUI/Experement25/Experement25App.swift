//
//  Experement25App.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//

    import SwiftUI
    @main
    struct Experement25App: App {
        @StateObject private var dataController = DataController25() // instance of the DataController class
        var body: some Scene {
            WindowGroup {
                Experement25()
                    .environment(\.managedObjectContext, dataController.container.viewContext) // We add the DataController to our SwiftUI environment. A managedObjectContext is essentially the live version of your data, which exists in memory until you actually write it to the disk/storage.
            }
        }
    }

