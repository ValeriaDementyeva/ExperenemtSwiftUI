//
//  DataController23.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//

import CoreData // Imports CoreData functions
import Foundation

class DataController23: ObservableObject {
    let container = NSPersistentContainer(name: "Experement23") // Tell CoreData to use our Experement23 datamodel. NSPersistentContainer is the actual data being saved to the device

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // merges duplicate objects based on their properties
        }
    }
}


