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
    private let pageCount = 3
    
    var body: some View {
        ZStack {
            store.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(alignment: .center, spacing: 8) {
                    Text("Reports")
                        .font(.largeTitle.bold())
                        .foregroundColor(store.textColor)
                    
                    Text("Visual insight into your spending")
                        .font(.subheadline)
                        .foregroundColor(store.textColor.opacity(0.6))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                .padding(.bottom, 20)

                TabView(selection: $selectedPage) {

                    CategoryPieChartView()
                        .environmentObject(store)
                        .tag(0)
                    
                    WeeklyBarChartView()
                        .environmentObject(store)
                        .tag(1)
                    
                    MonthlyLineChartView()
                        .environmentObject(store)
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 350)
                .padding(.horizontal)
                
                HStack(spacing: 8) {
                    ForEach(0..<pageCount, id: \.self) { idx in
                        Circle()
                            .fill(selectedPage == idx ? Color("Accent") : store.textColor.opacity(0.25))
                            .frame(width: selectedPage == idx ? 10 : 6, height: selectedPage == idx ? 10 : 6)
                            .animation(.easeInOut(duration: 0.18), value: selectedPage)
                    }
                }
                .padding(.top, 6)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 14) {

                    ForEach(Category.allCases, id: \.self) { category in
                        VStack(spacing: 8) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(category.color.opacity(0.15))

                                Image(systemName: category.systemImage)
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(category.color)
                            }
                            .frame(height: 50)

                            Text(category.rawValue)
                                .font(.caption2)
                                .foregroundColor(store.textColor.opacity(0.8))
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ReportsView().environmentObject(ExpenseStore())
}
