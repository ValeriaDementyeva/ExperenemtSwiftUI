//
//  DataController24.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//

import SwiftUI
import CoreData
class DataController24: ObservableObject{
   let container = NSPersistentContainer(name: "Experement24")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
