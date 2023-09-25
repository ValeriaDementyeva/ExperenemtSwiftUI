//
//  ExpenseItem.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 18.09.2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable { // Represents a single expense, Identifiable means that it can be identified, codable allows the JSON Encoder/Decoder to work with the data in the struct
    var id = UUID() // Generates a unique ID for each instance of ExpenseItem
    let name: String
    let type: String
    let amount: Double
}
