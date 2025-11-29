//
//  MonthlySummaryCard.swift
//  Financer
//
//  Created by Big Guy on 11/25/25.
//

import SwiftUI

struct MonthlySummaryCard: View {
    var spent: Double
    var budget: Double
    @EnvironmentObject var store: ExpenseStore
    
    private var remaining: Double { max(budget - spent, 0) }
    private var avgPerDay: Double {
        let day = Calendar.current.component(.day, from: Date())
        return spent / Double(day)
    }
    private var daysLeft: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let range = calendar.range(of: .day, in: .month, for: today) ?? 1..<1
        return (range.count - calendar.component(.day, from: today))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("This Month")
                    .font(.headline)
                    .foregroundColor(store.textColor)
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Spent")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(store.europeanCurrency ? "€" : "$")\(Int(spent))")
                        .font(.title3.bold())
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Remaining")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(store.europeanCurrency ? "€" : "$")\(Int(remaining))")
                        .font(.title3.bold())
                        .foregroundColor(remaining <= budget * 0.1 ? .red : .green)
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Avg/Day")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(store.europeanCurrency ? "€" : "$")\(Int(avgPerDay))")
                        .font(.headline.bold())
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Days Left")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(daysLeft)")
                        .font(.headline.bold())
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(store.textColor.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("Primary").opacity(0.2), lineWidth: 1)
                )
        )
    }
}
