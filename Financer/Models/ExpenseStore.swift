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
    @AppStorage("monthlyBudget") var monthlyBudget: Double = 1000
    @AppStorage("darkMode") var darkModeEnabled: Bool = true
    
    var backgroundColor: Color {
            darkModeEnabled ? Color("Background") : Color.white.opacity(0.80)
    }
    
    var textColor: Color {
        darkModeEnabled ? Color("TextPrimary") : Color("Background")
    }
    
    var monthlySpent: Double {
        let calendar = Calendar.current
        let now = Date()
        return expenses
            .filter { calendar.isDate($0.date, equalTo: now, toGranularity: .month) }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(expenses)
            let url = getDocumentsDirectory().appendingPathComponent("expenses.json")
            try data.write(to: url)
        } catch {
            print("Error saving expenses:", error)
        }
    }

    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        saveData()
    }
    
    func loadData() {
        let url = getDocumentsDirectory().appendingPathComponent("expenses.json")
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode([Expense].self, from: data) {
                self.expenses = decoded
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

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
    
    var todaysExpenseCount: Int {
        expenses.filter { Calendar.current.isDateInToday($0.date) }.count
    }
    
    init() {
        loadData()
    }
}
