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

    var body: some View {
        let isEmpty = store.spendingByCategory.isEmpty
        let data: [(category: Category, total: Double)] = isEmpty
            ? [(category: Category.food, total: 1.0)]
            : store.spendingByCategory.map { ($0.category, $0.total) }

        VStack(alignment: .leading, spacing: 30) {
            Text("Monthly Categories")
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(store.textColor)
            
            Chart(data, id: \.category) { item in
                SectorMark(
                    angle: .value("Amount", item.total),
                    innerRadius: .ratio(0.5)
                )
                .foregroundStyle(isEmpty ? store.textColor.opacity(0.1) : item.category.color)
            }
            .frame(height: 275)
        }
    }
}


#Preview {
    CategoryPieChartView()
        .environmentObject(ExpenseStore())
}
