//
//  ExpenseRow.swift
//  Financer
//
//  Created by Big Guy on 11/28/25.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: Expense
    let onDelete: () -> Void
    @EnvironmentObject var store: ExpenseStore
    @State private var showingEdit = false
    
    var body: some View {
        HStack(spacing: 14) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(expense.category.color.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: expense.category.systemImage)
                    .foregroundColor(expense.category.color)
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(expense.title)
                    .font(.headline)
                    .foregroundColor(store.textColor)
                
                Text(expense.date, formatter: dateFormatter)
                    .font(.caption)
                    .foregroundColor(store.textColor.opacity(0.5))
            }
            
            Spacer()
            
            Text("$\(expense.amount, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(store.textColor)
        }
        .padding(.vertical, 6)
        .contextMenu {
            Button {
                showingEdit = true
            } label: {
                Label("Update", systemImage: "pencil")
            }

            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .sheet(isPresented: $showingEdit) {
            AddExpenseFormView(expenseToEdit: expense) 
                .environmentObject(store)
        }
    }
}
