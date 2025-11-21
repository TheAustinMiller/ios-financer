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
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            AddExpenseView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
            ReportsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Reports")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    FinancerAppView()
}
