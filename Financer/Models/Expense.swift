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
    var category: Category
    var date: Date
}
