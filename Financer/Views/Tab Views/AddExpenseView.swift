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
            store.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // ------- HEADER -------
                VStack(alignment: .center, spacing: 8) {
                    Text("Expenses")
                        .font(.largeTitle.bold())
                        .foregroundColor(store.textColor)
                    
                    Text("Add or Review your purchasing")
                        .font(.subheadline)
                        .foregroundColor(store.textColor.opacity(0.6))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                // ------- SCROLLING EXPENSE LIST -------
                ScrollView {
                    LazyVStack(spacing: 16) {
                        let sorted = store.expenses.sorted(by: { $0.date > $1.date })
                        
                        ForEach(sorted) { expense in
                            ExpenseRow(expense: expense) {
                                deleteExpense(expense)
                            }
                            .environmentObject(store)
                            .padding(.horizontal)
                        }
                        
                        if store.expenses.isEmpty {
                            Text("No expenses yet — add one below!")
                                .foregroundColor(store.textColor.opacity(0.6))
                                .padding(.top, 40)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 180) // space for button + fade
                }
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .black.opacity(0), location: 0),
                            .init(color: .black, location: 0.05),
                            .init(color: .black, location: 0.85),
                            .init(color: .black.opacity(0), location: 1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                
                // ------- ADD EXPENSE BUTTON -------
                VStack {
                    Button {
                        showingAddExpense = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            Text("Add Expense")
                                .font(.title2.bold())
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                }
                .background(
                    store.backgroundColor
                        .opacity(0.95)
                        .blur(radius: 10)
                )
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddExpenseFormView()
                .environmentObject(store)
        }
    }
    
    
    // ------- DELETE HELPER -------
    private func deleteExpense(_ expense: Expense) {
        if let index = store.expenses.firstIndex(where: { $0.id == expense.id }) {
            store.expenses.remove(at: index)
            store.saveData()
        }
    }
}

#Preview {
    AddExpenseView()
        .environmentObject(ExpenseStore())
}
