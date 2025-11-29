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
    @State private var showingClearConfirmation = false

    var body: some View {
        NavigationStack {
            ZStack {
                store.backgroundColor
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    
                    // ---------- HEADER ----------
                    VStack(alignment: .center, spacing: 4) {
                        Text("Settings")
                            .font(.largeTitle.bold())
                            .foregroundColor(store.textColor)
                        
                        Text("Manage your preferences")
                            .font(.subheadline)
                            .foregroundColor(store.textColor.opacity(0.6))
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)
                    
                    // ---------- SCROLLABLE SETTINGS ----------
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            
                            // Financial Settings Section
                            Text("Financial Settings")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(store.textColor.opacity(0.7))
                                .textCase(.uppercase)
                                .tracking(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)
                            
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
                            
                            // Clear Expenses Section
                            VStack(spacing: 0) {
                                Button {
                                    showingClearConfirmation = true
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Clear Expenses")
                                                .font(.headline)
                                                .foregroundColor(store.textColor)
                                            
                                            Text("Tap to clear all your expenses")
                                                .font(.caption)
                                                .foregroundColor(store.textColor.opacity(0.6))
                                        }
                                        Spacer()
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
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
                            // Confirmation dialog
                            .confirmationDialog(
                                "Are you sure you want to clear all expenses?",
                                isPresented: $showingClearConfirmation,
                                titleVisibility: .visible
                            ) {
                                Button("Clear Expenses", role: .destructive) {
                                    store.clearExpenses()
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                            
                            // Aesthetic Settings Section
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
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .sheet(isPresented: $showingBudgetSheet) {
                BudgetInputSheet(monthlyBudget: $store.monthlyBudget)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ExpenseStore())
}
