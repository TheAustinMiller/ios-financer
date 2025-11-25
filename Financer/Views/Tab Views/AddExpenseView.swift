//
//  AddExpense.swift
//  Financer
//
//  Created by Big Guy on 11/21/25.
//

import SwiftUI

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

struct AddExpenseView: View {
    @State private var showingAddExpense = false
    @EnvironmentObject var store: ExpenseStore

    var body: some View {
        ZStack {
            Color(store.backgroundColor)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Button {
                    showingAddExpense = true
                } label: {
                    HStack {
                        Text("Add Expense")
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                    .font(.title2.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("Primary"))
                    .foregroundColor(Color("TextPrimary"))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                if store.expenses.count > 0 {
                    List {
                        ForEach(store.expenses.sorted(by: { $0.date > $1.date })) { expense in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(expense.title)
                                        .font(.headline)
                                        .foregroundColor(store.textColor)

                                    Text("$\(expense.amount, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(store.textColor.opacity(0.7))
                                }
                                .frame(width: 140, alignment: .leading)
                                
                                Image(systemName: expense.category.systemImage)
                                    .font(.title3)
                                    .foregroundColor(expense.category.color)
                                    .frame(width: 40)
                                Spacer()
                                Text(expense.date, formatter: dateFormatter)
                                    .font(.headline)
                                    .foregroundColor(store.textColor)
                                    .frame(width: 90, alignment: .trailing)
                            }
                            .padding(.vertical, 6)
                            .listRowBackground(store.backgroundColor)
                        }
                        .onDelete(perform: store.deleteExpense)
                        .tint(store.textColor)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    HStack {
                        Text("Add an expense to begin")
                            .foregroundColor(store.textColor)
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddExpenseFormView()
                .environmentObject(store)
        }
    }
}

#Preview {
    AddExpenseView()
        .environmentObject(ExpenseStore())
}
