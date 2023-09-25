//
//  ExtentionString.swift
//  ExperenemtSwiftUI
//
//  Created by Валерия Дементьева on 20.09.2023.
//
import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
