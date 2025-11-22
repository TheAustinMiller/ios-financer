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
            id: UUID(),
            title: title,
            amount: Double(amount) ?? 0,
            category: selectedCategory.rawValue,
            date: date
        )
        store.addExpense(expense)
        dismiss()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Title Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TextPrimary").opacity(0.7))
                            .textCase(.uppercase)
                            .tracking(0.5)
                        
                        TextField("e.g., Grocery shopping", text: $title)
                            .font(.body)
                            .foregroundColor(Color("TextPrimary"))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.05))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("Primary").opacity(0.3), lineWidth: 1)
                                    )
                            )
                            .tint(Color("Accent"))
                    }
                    
                    // Amount Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Amount")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TextPrimary").opacity(0.7))
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
                                .foregroundColor(Color("TextPrimary"))
                                .keyboardType(.decimalPad)
                                .tint(Color("Accent"))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.05))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color("Primary").opacity(0.3), lineWidth: 1)
                                )
                        )
                    }
                    
                    // Category Picker
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Category")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TextPrimary").opacity(0.7))
                            .textCase(.uppercase)
                            .tracking(0.5)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ForEach(Category.allCases, id: \.self) { category in
                                CategoryButton(
                                    category: category,
                                    isSelected: selectedCategory == category
                                ) {
                                    selectedCategory = category
                                }
                            }
                        }
                    }
                    
                    // Date Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TextPrimary").opacity(0.7))
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
                                    .fill(Color.white.opacity(0.05))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("Primary").opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                    Spacer()
                    
                    // Save Button
                    Button(action: saveExpense) {
                        Text("Save Expense")
                            .font(.headline)
                            .foregroundColor(Color("TextPrimary"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(saveButtonBackground)
                    }
                    .disabled(isFormInvalid)
                }
                .padding(20)
            }
            .background(Color("Background"))
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(Color("TextPrimary").opacity(0.7))
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Category Button Component
struct CategoryButton: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: category.systemImage)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? Color("TextPrimary") : Color("TextPrimary").opacity(0.5))
                    .frame(height: 28)
                
                Text(category.rawValue.split(separator: " ").first.map(String.init) ?? "")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? Color("TextPrimary") : Color("TextPrimary").opacity(0.5))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color("Accent").opacity(0.2) : Color.white.opacity(0.05))
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
