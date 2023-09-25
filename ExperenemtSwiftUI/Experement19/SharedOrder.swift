//
//  SharedOrder.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 20.09.2023.
//

import SwiftUI

@dynamicMemberLookup // This attribute allows us to dynamically handle access properties that don't directly exist. Yes, it's a bit confusing.

class SharedOrder: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = Order() // Creates an instance of our order struct

    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T { // This adds a custom subscript using a dynamic member keyPath.
        data[keyPath: keyPath]
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keyPath]
        }

        set {
            data[keyPath: keyPath] = newValue
        }
    }

}

struct Order: Codable { // We now use a struct that automatically conforms to Codable, meaning we don't need the initializer or hand-coded JSONEncoder and Decoder anymore.

    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }

    var type = 0 // Vanilla by default, as it's the first entry in the types array
    var quantity = 3 // Default quantity that is ordered

    var specialRequestEnabled = false { // Has the user requested a special request? False by default.
        didSet {
            if specialRequestEnabled == false { // If specialRequestEnabled is false, the two extra options are false by default as well
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false // Has the user requested extra frosting? False by default.
    var addSprinkles = false // Has the user requested sprinkles? False by default.

    // Delivery details

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool { // Used to validate that none of the address fields are empty
        if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
            return false
        }
        return true
    }

    // Product cost

    var cost: Double {

        // 2$ per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // 1$ per cake for extra frosting

        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost

        // Side note: A Double is not ideal for currency, but we have not yet learned better ways in this point in time (Day 50 of the 100 Days of SwiftUI). We will in the future, though!
    }
}
