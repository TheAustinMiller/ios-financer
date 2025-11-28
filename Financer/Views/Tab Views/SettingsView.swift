//
//  SettingsView.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: ExpenseStore
    @State private var showingBudgetSheet = false
    @State private var darkModeEnabled = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // ——— SECTION TITLE ———
                    Text("Financial Settings")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(store.textColor.opacity(0.7))
                        .textCase(.uppercase)
                        .tracking(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)
                        .padding(.top, 10)
                    
                    // ——— SETTINGS CARD ———
                    VStack(spacing: 0) {
                        Button {
                            showingBudgetSheet = true
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Monthly Budget")
                                        .font(.headline)
                                        .foregroundColor(store.textColor)

                                    Text("Tap to change your monthly limit")
                                        .font(.caption)
                                        .foregroundColor(store.textColor.opacity(0.6))
                                }

                                Spacer()

                                Text("$\(store.monthlyBudget, specifier: "%.0f")")
                                    .font(.headline)
                                    .foregroundColor(Color("Accent"))
                            }
                            .padding()
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(store.textColor.opacity(0.05))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("Primary").opacity(0.2), lineWidth: 1)
                            )
                    )
                    
                    // CLEAR BUTTON TO DO HERE
                    
                    Text("Aesthetic Settings")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(store.textColor.opacity(0.7))
                        .textCase(.uppercase)
                        .tracking(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)
                        .padding(.top, 10)
                    
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Dark Mode")
                                    .font(.headline)
                                    .foregroundColor(store.textColor)

                                Text("Tap to toggle dark mode")
                                    .font(.caption)
                                    .foregroundColor(store.textColor.opacity(0.6))
                            }

                            Spacer()

                            Toggle("", isOn: $store.darkModeEnabled)
                                .toggleStyle(SwitchToggleStyle(tint: Color("Accent")))
                        }
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(store.textColor.opacity(0.05))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("Primary").opacity(0.2), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .background(store.backgroundColor)
            .ignoresSafeArea(edges: .bottom)
            .toolbar(.hidden)
        }
        .sheet(isPresented: $showingBudgetSheet) {
            BudgetInputSheet(monthlyBudget: $store.monthlyBudget)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingsView()
        .environmentObject(ExpenseStore())
}

