//
//  CategoryPieChartView.swift
//  Financer
//
//  Created by Big Guy on 11/22/25.
//

import SwiftUI
import Charts

struct CategoryPieChartView: View {
    @EnvironmentObject var store: ExpenseStore
    @State private var showingTotalBreakdown = false

    private var calendar: Calendar { .current }

    // Aggregates expenses by category for the given list
    private func aggregate(_ expenses: [Expense]) -> [(category: Category, total: Double)] {
        let grouped = Dictionary(grouping: expenses, by: { $0.category })
        return grouped.map { (category: $0.key, total: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.total > $1.total }
    }

    // Data for the monthly view: only expenses in the current month
    private var monthlyData: [(category: Category, total: Double)] {
        let filtered = store.expenses.filter {
            calendar.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }
        return aggregate(filtered)
    }

    // Data for the total/all-time view
    private var totalData: [(category: Category, total: Double)] {
        aggregate(store.expenses)
    }

    var body: some View {
        // Choose data depending on current mode
        let data = showingTotalBreakdown ? totalData : monthlyData
        let isEmpty = data.isEmpty

        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Category Breakdown")
                        .font(.headline)
                        .foregroundColor(store.textColor)
                }

                Spacer()

                // small text indicator
                Text(showingTotalBreakdown ? "Total" : "Monthly")
                    .font(.caption2.weight(.semibold))
                    .foregroundColor(store.textColor.opacity(0.7))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(store.textColor.opacity(0.03)))
            }
            .padding(.horizontal)

            Chart {
                if isEmpty {
                    // single dummy slice so the chart renders layout
                    SectorMark(
                        angle: .value("Amount", 1),
                        innerRadius: .ratio(0.5)
                    )
                    .foregroundStyle(store.textColor.opacity(0.12))
                } else {
                    ForEach(data, id: \.category) { item in
                        SectorMark(
                            angle: .value("Amount", item.total),
                            innerRadius: .ratio(0.5)
                        )
                        .foregroundStyle(item.category.color)
                    }
                }
            }
            .frame(height: 275)
            .padding(.horizontal)
            .overlay {
                if isEmpty {
                    VStack {
                        Text("No expenses yet")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            // Toggle between monthly / total on tap
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.25)) {
                    showingTotalBreakdown.toggle()
                }
            }
        }
    }
}

#Preview {
    CategoryPieChartView()
        .environmentObject(ExpenseStore())
}
