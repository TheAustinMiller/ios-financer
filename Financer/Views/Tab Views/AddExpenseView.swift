
//
//  AddExpense.swift
//  Financer
//
//  Created by Big Guy on 11/21/25.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var showingAddExpense = false
    @EnvironmentObject var store: ExpenseStore

    var body: some View {
        ZStack {
            Color("Background")
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

                List {
                    ForEach(store.expenses) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.title)
                                    .font(.headline)
                                    .foregroundColor(Color("TextPrimary"))

                                Text("$\(expense.amount, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(Color("TextPrimary").opacity(0.7))
                            }
                        }
                        .padding(.vertical, 6)
                        .listRowBackground(Color("Background"))
                    }
                }
                .scrollContentBackground(.hidden)
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
