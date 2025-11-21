//
//  ExpenseStore.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI
import Combine

class ExpenseStore: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [Category] = []

    func addExpense(_ expense: Expense) { expenses.append(expense) }
    func deleteExpense(at offsets: IndexSet) { expenses.remove(atOffsets: offsets) }
    func updateExpense(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses[index] = expense
        }
    }
}
