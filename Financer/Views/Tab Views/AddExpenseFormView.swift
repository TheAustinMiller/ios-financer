//
//  AddExpenseFormView.swift
//  Financer
//
//  Created by Big Guy on 11/21/25.
//

import SwiftUI

struct AddExpenseFormView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: ExpenseStore

    @State private var title = ""
    @State private var amount = ""
    @State private var category = ""
    @State private var date = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title").foregroundColor(Color("TextPrimary"))) {
                    TextField("Enter title", text: $title)
                        .foregroundColor(Color("TextPrimary"))
                        .tint(Color("Accent"))
                        .listRowBackground(Color("Background"))
                }

                Section(header: Text("Amount").foregroundColor(Color("TextPrimary"))) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .foregroundColor(Color("TextPrimary"))
                        .tint(Color("Accent"))
                        .listRowBackground(Color("Background"))
                }

                Section(header: Text("Category").foregroundColor(Color("TextPrimary"))) {
                    TextField("Enter category", text: $category)
                        .foregroundColor(Color("TextPrimary"))
                        .tint(Color("Accent"))
                        .listRowBackground(Color("Background"))
                }

                Section(header: Text("Date").foregroundColor(Color("TextPrimary"))) {
                    DatePicker("Select date", selection: $date, displayedComponents: .date)
                        .tint(Color("Accent"))
                        .listRowBackground(Color("Background"))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("Background"))
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color("Accent"))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let expense = Expense(
                            id: UUID(),
                            title: title,
                            amount: Double(amount) ?? 0,
                            category: category,
                            date: date
                        )
                        store.addExpense(expense)
                        dismiss()
                    }
                    .disabled(title.isEmpty || amount.isEmpty)
                    .foregroundColor(title.isEmpty || amount.isEmpty ? Color.gray : Color("Accent"))
                }
            }
        }
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

#Preview {
    AddExpenseFormView()
        .environmentObject(ExpenseStore())
}
