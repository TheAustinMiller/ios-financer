//
//  ReportsView.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI
import Charts

struct ReportsView: View {
    @EnvironmentObject var store: ExpenseStore
    @State private var selectedPage = 0
    
    var body: some View {
        ZStack {
            store.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {

                // ---- SAFE AREA COMPENSATION ----
                Spacer().frame(height: 60)

                // ---- HEADER ----
                VStack(alignment: .leading, spacing: 6) {
                    Text("Reports")
                        .font(.largeTitle.bold())
                        .foregroundColor(store.textColor)
                    
                    Text("Visual insight into your spending")
                        .font(.subheadline)
                        .foregroundColor(store.textColor.opacity(0.6))
                }
                .padding(.horizontal)
                .padding(.bottom, 20)

                
                // ---- SWIPEABLE CAROUSEL ----
                TabView(selection: $selectedPage) {

                    CategoryPieChartView()
                        .environmentObject(store)
                        .tag(2)
                    
                    WeeklyBarChartView()
                        .environmentObject(store)
                        .tag(1)
                    
                    MonthlyLineChartView()
                        .environmentObject(store)
                        .tag(0)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 350)
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ReportsView().environmentObject(ExpenseStore())
}
