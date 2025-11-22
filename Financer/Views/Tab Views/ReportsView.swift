//
//  ReportsView.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

struct ReportsView: View {
    @EnvironmentObject var store: ExpenseStore
    
    var body: some View {
        VStack {
            CategoryPieChartView()
                .environmentObject(store)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

#Preview {
    ReportsView()
        .environmentObject(ExpenseStore())
}
