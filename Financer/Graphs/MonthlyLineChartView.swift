//
//  MonthlyLineChartView.swift
//  Financer
//
//  Created by Big Guy on 12/6/25.
//

import SwiftUI
import Charts

enum TimeSpan: CaseIterable {
    case week, month, year
    
    var displayName: String {
        switch self {
        case .week: return "Weekly"
        case .month: return "Monthly"
        case .year: return "Yearly"
        }
    }
}

struct MonthlyLineChartView: View {
    @EnvironmentObject var store: ExpenseStore
    @State private var selectedSpan: TimeSpan = .month

    private var cumulativeData: [(x: String, total: Double)] {
        let calendar = Calendar.current
        let today = Date()
        
        switch selectedSpan {
        case .week:
            let filtered = store.expenses.filter {
                calendar.isDate($0.date, equalTo: today, toGranularity: .weekOfYear)
            }.sorted { $0.date < $1.date }
            
            var runningTotal: Double = 0
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE"
            
            return filtered.map { expense in
                runningTotal += expense.amount
                return (x: formatter.string(from: expense.date), total: runningTotal)
            }
            
        case .month:
            let filtered = store.expenses.filter {
                calendar.isDate($0.date, equalTo: today, toGranularity: .month)
            }.sorted { $0.date < $1.date }
            
            var runningTotal: Double = 0
            return filtered.map { expense in
                runningTotal += expense.amount
                let day = calendar.component(.day, from: expense.date)
                return (x: "\(day)", total: runningTotal)
            }
            
        case .year:
            let filtered = store.expenses.filter {
                calendar.isDate($0.date, equalTo: today, toGranularity: .year)
            }.sorted { $0.date < $1.date }
            
            var runningTotal: Double = 0
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            
            return filtered.map { expense in
                runningTotal += expense.amount
                return (x: formatter.string(from: expense.date), total: runningTotal)
            }
        }
    }
    
    var body: some View {
        let isEmpty = cumulativeData.isEmpty
        
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Cumulative Spending")
                    .font(.headline)
                    .foregroundColor(store.textColor)
                    .padding(.horizontal)
                Spacer()
                Text("\(selectedSpan.displayName)")
                    .font(.caption2.weight(.semibold))
                    .foregroundColor(store.textColor.opacity(0.7))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(store.textColor.opacity(0.03)))
            }
            
            
            // Chart
            Chart {
                if isEmpty {
                    LineMark(
                        x: .value("X", 0),
                        y: .value("Total", 0)
                    )
                    .foregroundStyle(Color.gray.opacity(0.3))
                } else {
                    ForEach(Array(cumulativeData.enumerated()), id: \.offset) { _, entry in
                        LineMark(
                            x: .value("X", entry.x),
                            y: .value("Total", entry.total)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(Color("Accent"))
                        .lineStyle(StrokeStyle(lineWidth: 3))
                    }
                }
            }
            .frame(height: 275)
            .padding(.horizontal)
            .contentShape(Rectangle()) // allows tapping anywhere
            .onTapGesture {
                withAnimation(.easeInOut) {
                    // Rotate through all TimeSpans
                    if let currentIndex = TimeSpan.allCases.firstIndex(of: selectedSpan) {
                        let nextIndex = (currentIndex + 1) % TimeSpan.allCases.count
                        selectedSpan = TimeSpan.allCases[nextIndex]
                    }
                }
            }
            .overlay {
                if isEmpty {
                    Text("No expenses for this period")
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
