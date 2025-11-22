//
//  ExpenseStore.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI
import Combine

class ExpenseStore: ObservableObject {
    @Published var expenses: [Expense] = [
        Expense(id: UUID(), title: "Groceries", amount: 150.00, category: .food, date: Date()),
        Expense(id: UUID(), title: "Coffee", amount: 3.50, category: .food, date: Date()),
        Expense(id: UUID(), title: "Public Transport", amount: 2.99, category: .transport, date: Date())
    ]
    @Published var categories: [Category] = []

    func addExpense(_ expense: Expense) { expenses.append(expense) }
    func deleteExpense(at offsets: IndexSet) { expenses.remove(atOffsets: offsets) }
    func updateExpense(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses[index] = expense
        }
    }
    var spendingByCategory: [(category: Category, total: Double)] {
        Category.allCases.map { category in
            let total = expenses
                .filter { $0.category == category }
                .map(\.amount)
                .reduce(0, +)
            
            return (category, total)
        }
        .filter { $0.total > 0 }
    }

}
