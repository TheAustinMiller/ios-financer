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
        ZStack(alignment: .top) {
            Color("Background")
                .ignoresSafeArea()

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
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseFormView()
                    .environmentObject(store)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

