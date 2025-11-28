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

    // Optional expense to edit
    var expenseToEdit: Expense?

    @State private var title = ""
    @State private var amount = ""
    @State private var selectedCategory: Category = .food
    @State private var date = Date()

    private var isFormInvalid: Bool {
        title.isEmpty || amount.isEmpty
    }

    private var saveButtonBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(isFormInvalid ? AnyShapeStyle(Color.gray.opacity(0.3)) : AnyShapeStyle(buttonGradient))
    }

    private var buttonGradient: LinearGradient {
        LinearGradient(
            colors: [Color("Primary"), Color("Accent")],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private func saveExpense() {
        let expense = Expense(
            id: expenseToEdit?.id ?? UUID(),
            title: title,
            amount: Double(amount) ?? 0,
            category: selectedCategory,
            date: date
        )

        if let _ = expenseToEdit {
            store.updateExpense(expense)
        } else {
            store.addExpense(expense)
        }

        dismiss()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    TitleInputView(title: $title, store: store)
                    AmountInputView(amount: $amount, store: store)
                    CategoryPickerView(selectedCategory: $selectedCategory, store: store)
                    DatePickerView(date: $date, store: store)

                    Button(action: saveExpense) {
                        Text(expenseToEdit != nil ? "Update Expense" : "Save Expense")
                            .font(.headline)
                            .foregroundColor(store.textColor)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(saveButtonBackground)
                    }
                    .disabled(isFormInvalid)
                }
                .padding(20)
            }
            .background(store.backgroundColor)
            .navigationTitle(expenseToEdit != nil ? "Update Expense" : "Add Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(store.textColor.opacity(0.7))
                    }
                }
            }
        }
        .onAppear {
            if let expense = expenseToEdit {
                title = expense.title
                amount = String(format: "%.2f", expense.amount)
                selectedCategory = expense.category
                date = expense.date
            }
        }
    }
}

// MARK: - Subviews

struct TitleInputView: View {
    @Binding var title: String
    var store: ExpenseStore

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Title")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(store.textColor.opacity(0.7))
                .textCase(.uppercase)
                .tracking(0.5)

            TextField("e.g., Grocery shopping", text: $title)
                .font(.body)
                .foregroundColor(store.textColor)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(store.textColor.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("Primary").opacity(0.3), lineWidth: 1)
                        )
                )
                .tint(Color("Accent"))
        }
    }
}

struct AmountInputView: View {
    @Binding var amount: String
    var store: ExpenseStore

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Amount")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(store.textColor.opacity(0.7))
                .textCase(.uppercase)
                .tracking(0.5)

            HStack {
                Text("$")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color("Primary"))

                TextField("0.00", text: $amount)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(store.textColor)
                    .keyboardType(.decimalPad)
                    .tint(Color("Accent"))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(store.textColor.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("Primary").opacity(0.3), lineWidth: 1)
                    )
            )
        }
    }
}

struct CategoryPickerView: View {
    @Binding var selectedCategory: Category
    var store: ExpenseStore

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Category")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(store.textColor.opacity(0.7))
                .textCase(.uppercase)
                .tracking(0.5)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                ForEach(Category.allCases, id: \.self) { category in
                    CategoryButton(category: category, isSelected: selectedCategory == category) {
                        selectedCategory = category
                    }
                }
            }
        }
    }
}

struct DatePickerView: View {
    @Binding var date: Date
    var store: ExpenseStore

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(store.textColor.opacity(0.7))
                .textCase(.uppercase)
                .tracking(0.5)

            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .tint(Color("Accent"))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(store.textColor.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("Primary").opacity(0.3), lineWidth: 1)
                        )
                )
        }
    }
}

// MARK: - Category Button

struct CategoryButton: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void

    @EnvironmentObject var store: ExpenseStore

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: category.systemImage)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? category.color : store.textColor)
                    .frame(height: 28)

                Text(category.rawValue.split(separator: " ").first.map(String.init) ?? "")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? store.textColor : store.textColor.opacity(0.5))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color("Accent").opacity(0.2) : store.textColor.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                isSelected ? Color("Accent") : Color("Primary").opacity(0.3),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AddExpenseFormView()
        .environmentObject(ExpenseStore())
}
