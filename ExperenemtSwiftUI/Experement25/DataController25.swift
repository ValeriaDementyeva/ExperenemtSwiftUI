//
//  DataController25.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//


    import SwiftUI
    import CoreData

    class DataController25: ObservableObject{
       let container = NSPersistentContainer(name: "Experement25")
        init() {
            container.loadPersistentStores { description, error in
                if let error = error{
                    print("Core Data failed to load: \(error.localizedDescription)")
                    return
                }
                self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // merges duplicate objects based on their properties

            }
        }
    }
