//
//  Singer+CoreDataProperties.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 25.09.2023.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstMane: String {
firstName ?? "Unknovn"
    }

    var wrappedLastMane: String {
lastName ?? "Unknovn"
    }

}

extension Singer : Identifiable {

}
