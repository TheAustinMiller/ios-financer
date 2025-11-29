//
//  WeeklyBarChartView.swift
//  Financer
//
//  Created by Big Guy on 11/27/25.
//

import SwiftUI
import Charts

struct WeeklyBarChartView: View {
    @EnvironmentObject var store: ExpenseStore
    
    private var weeklyTotals: [(day: String, total: Double)] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        let filtered = store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear)
        }
        
        let grouped = Dictionary(grouping: filtered) {
            formatter.string(from: $0.date)
        }
        
        let mapped = grouped.map { (day: $0.key, total: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.day < $1.day }
        
        // If no data, return a single dummy value
        return mapped.isEmpty ? [(day: "Mon", total: 0.0)] : mapped
    }
    
    var body: some View {
        let isEmpty = store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear)
        }.isEmpty
        
        VStack(alignment: .leading) {
            Text("Weekly Breakdown")
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(store.textColor)
            
            Chart {
                ForEach(weeklyTotals, id: \.day) { entry in
                    BarMark(
                        x: .value("Day", entry.day),
                        y: .value("Total", entry.total)
                    )
                    .foregroundStyle(isEmpty ? Color.gray.opacity(0.3) : Color("Primary"))
                }
            }
            .frame(height: 275)
            .padding(.horizontal)
            .overlay {
                if isEmpty {
                    Text("No expenses this week")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    WeeklyBarChartView()
        .environmentObject(ExpenseStore())
}
