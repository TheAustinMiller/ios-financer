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
    @State private var showYearly = false
    
    // -------- WEEKLY DATA --------
    private var weeklyTotals: [(day: String, total: Double)] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        let filtered = store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear)
        }
        
        let grouped = Dictionary(grouping: filtered) {
            formatter.string(from: $0.date)
        }
        
        let mapped = grouped.map { (day: $0.key,
                                    total: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.day < $1.day }
        
        return mapped.isEmpty ? [(day: "Mon", total: 0.0)] : mapped
    }
    
    private var weeklyIsEmpty: Bool {
        store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear)
        }.isEmpty
    }
    
    // -------- YEARLY DATA --------
    private var monthlyTotals: [(month: String, total: Double)] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        
        let filtered = store.expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .year)
        }
        
        let grouped = Dictionary(grouping: filtered) {
            formatter.string(from: $0.date)
        }
        
        // Ensure months appear in correct order
        let allMonths = Calendar.current.shortMonthSymbols
        
        let mapped = allMonths.map { month in
            let total = grouped[month]?.reduce(0) { $0 + $1.amount } ?? 0
            return (month: month, total: total)
        }
        
        return mapped
    }
    
    private var yearlyIsEmpty: Bool {
        monthlyTotals.allSatisfy { $0.total == 0 }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Expense Breakdown")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(store.textColor)
                Spacer()
                Text(showYearly ? "Yearly" : "Weekly")
                    .font(.caption2.weight(.semibold))
                    .foregroundColor(store.textColor.opacity(0.7))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(store.textColor.opacity(0.03)))
            }
            
            Chart {
                if showYearly {
                    ForEach(monthlyTotals, id: \.month) { entry in
                        BarMark(
                            x: .value("Month", entry.month),
                            y: .value("Total", entry.total)
                        )
                        .foregroundStyle(
                            yearlyIsEmpty
                            ? Color.gray.opacity(0.3)
                            : Color("Primary")
                        )
                    }
                } else {
                    ForEach(weeklyTotals, id: \.day) { entry in
                        BarMark(
                            x: .value("Day", entry.day),
                            y: .value("Total", entry.total)
                        )
                        .foregroundStyle(
                            weeklyIsEmpty
                            ? Color.gray.opacity(0.3)
                            : Color("Primary")
                        )
                    }
                }
            }
            .frame(height: 275)
            .padding(.horizontal)
            .contentShape(Rectangle()) // <-- allows tapping anywhere
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showYearly.toggle()
                }
            }
            .overlay {
                if showYearly && yearlyIsEmpty {
                    Text("No expenses yet")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else if !showYearly && weeklyIsEmpty {
                    Text("No expenses yet")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    WeeklyBarChartView()
        .environmentObject(ExpenseStore())
}
