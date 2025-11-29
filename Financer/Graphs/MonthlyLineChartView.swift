//
//  MonthlyLineChartView.swift
//  Financer
//
//  Created by Big Guy on 11/27/25.
//

import SwiftUI
import Charts

struct MonthlyLineChartView: View {
    @EnvironmentObject var store: ExpenseStore
    
    private var dailySpending: [(day: Int, total: Double)] {
        let filtered = store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }
        
        let grouped = Dictionary(grouping: filtered) { Calendar.current.component(.day, from: $0.date) }
        
        let mapped = grouped.map { (day: $0.key, total: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.day < $1.day }
        
        return mapped.isEmpty ? [(day: 1, total: 0.0)] : mapped
    }
    
    var body: some View {
        let isEmpty = store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }.isEmpty
        
        VStack(alignment: .leading) {
            Text("Monthly Spending")
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(store.textColor)

            Chart {
                ForEach(dailySpending, id: \.day) { entry in
                    LineMark(
                        x: .value("Day", entry.day),
                        y: .value("Total", entry.total)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(isEmpty ? Color.gray.opacity(0.3) : Color("Accent"))
                }
            }
            .frame(height: 275)
            .padding(.horizontal)
            .overlay {
                if isEmpty {
                    Text("No expenses this month")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    MonthlyLineChartView()
        .environmentObject(ExpenseStore())
}
