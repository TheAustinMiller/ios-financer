//
//  Expense.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

struct Expense: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var amount: Double
    var category: String
    var date: Date
}

struct Category: Identifiable, Equatable {
    var id: UUID
    var name: String
    var color: Color
}
