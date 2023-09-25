//
//  DataController.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import CoreData // Imports CoreData functions
import Foundation

class DataController1: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm1") // Tell CoreData to use our Bookworm datamodel. NSPersistentContainer is the actual data being saved to the device

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
