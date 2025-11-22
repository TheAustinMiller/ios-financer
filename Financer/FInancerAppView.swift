//
//  FInancerAppView.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

struct FinancerAppView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            AddExpenseView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }
            ReportsView()
                .tabItem {
                    Label("Reports", systemImage: "chart.bar.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .tint(Color("Primary"))
    }
}

#Preview {
    FinancerAppView()
        .environmentObject(ExpenseStore())
}
