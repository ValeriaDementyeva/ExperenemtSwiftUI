////
////  Order.swift
////  ExperenemtSwiftUI
////
////  Created by Валерия Дементьева on 20.09.2023.
////
//
//import SwiftUI
//
//class Order: ObservableObject, Codable {
//
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//
//
//
//    // Order details
//    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
//
//    @Published var type = 0 // Vanilla by default, as it's the first entry in the types array
//    @Published var quantity = 3 // Default quantity that is ordered
//
//    @Published var specialRequestEnabled = false { // Has the user requested a special request? False by default.
//        didSet {
//            if specialRequestEnabled == false { // If specialRequestEnabled is false, the two extra options are false by default as well
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//
//    @Published var extraFrosting = false // Has the user requested extra frosting? False by default.
//    @Published var addSprinkles = false // Has the user requested sprinkles? False by default.
//
//    // Delivery details
//
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//
//    var hasValidAddress: Bool { // Used to validate that none of the address fields are empty
//           if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
//               return false
//           }
//           return true
//       }
//    // Product cost
//
//    var cost: Double {
//
//        // 2$ per cake
//        var cost = Double(quantity) * 2
//
//        // complicated cakes cost more
//        cost += (Double(type) / 2)
//
//        // 1$ per cake for extra frosting
//
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//
//        // $0.50 per cake for sprinkles
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//
//        return cost
//
//        // Side note: A Double is not ideal for currency, but we have not yet learned better ways in this point in time (Day 50 of the 100 Days of SwiftUI). We will in the future, though!
//    }
//
//    init() {} // Empty initalizer so we can create an instance of the order class without any data
//
//    func encode (to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//}
