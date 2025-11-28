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
    
    // Group expenses by day of month
    private var dailySpending: [(day: Int, total: Double)] {
        let grouped = Dictionary(grouping: store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }) { Calendar.current.component(.day, from: $0.date) }
        
        return grouped.map { (day: $0.key, total: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.day < $1.day }
    }
    
    var body: some View {
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
                    .foregroundStyle(Color("Accent"))
                }
            }
            .padding()
        }
    }
}
