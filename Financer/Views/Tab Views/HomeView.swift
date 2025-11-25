//
//  HomeView.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

extension Date {
    func isToday() -> Bool {
        Calendar.current.isDateInToday(self)
    }
}

struct HomeView: View {
    @EnvironmentObject var store: ExpenseStore
    
    private var todayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }

    private var today: String {
        todayFormatter.string(from: Date())
    }
    
    private var todaysExpenses: [Expense] {
        store.expenses.filter { $0.date.isToday() }
    }

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 8) {
                
                Text("Welcome to Financer")
                    .foregroundColor(Color("TextPrimary"))
                    .font(.largeTitle.bold())
                    .padding(.top, 40)
                
                Text("\(today) - \(todaysExpenses.count) expense\(todaysExpenses.count == 1 ? "" : "s") today")
                    .font(.subheadline)
                    .foregroundColor(Color("TextPrimary").opacity(0.6))
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ExpenseStore())
}
