//
//  FInancerAppView.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

struct FinancerAppView: View {
    
    struct Expense: Identifiable, Codable, Equatable {
        var id: UUID
        var title: String
        var amount: Double
        var category: String
        var date: Date
    }

    struct Category: Identifiable, Codable, Equatable {
        var id: UUID
        var name: String
        var color: Color
    }
    
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

