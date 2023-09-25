//
//  StringIsEmpty.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 21.09.2023.
//

import Foundation
extension String {
    var isEmptyReally: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
