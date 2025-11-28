//
//  CategoryPieChartView.swift
//  Financer
//
//  Created by Big Guy on 11/22/25.
//

import SwiftUI
import Charts

import Charts

struct CategoryPieChartView: View {
    @EnvironmentObject var store: ExpenseStore

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Monthly Categories")
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(store.textColor)
            
            Chart(store.spendingByCategory, id: \.category) { item in
                SectorMark(
                    angle: .value("Amount", item.total),
                    innerRadius: .ratio(0.5)
                )
                .foregroundStyle(item.category.color)
            }
            .frame(height: 275)
        }
    }
}

#Preview {
    CategoryPieChartView()
        .environmentObject(ExpenseStore())
}
