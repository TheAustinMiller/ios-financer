//
//  BudgetInputSheet.swift
//  Financer
//
//  Created by Big Guy on 11/24/25.
//

import SwiftUI

struct BudgetInputSheet: View {
    @Binding var monthlyBudget: Double
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: ExpenseStore
    
    @State private var tempBudget: String = ""
    
    private var isInputValid: Bool {
        !tempBudget.isEmpty && Double(tempBudget) != nil
    }
    
    private var saveButtonBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(
                isInputValid
                    ? AnyShapeStyle(LinearGradient(
                        colors: [Color("Primary"), Color("Accent")],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    : AnyShapeStyle(Color.gray.opacity(0.3))
            )
    }
    
    var body: some View {
        VStack(spacing: 32) {
            
            // TITLE
            Text("Set Monthly Budget")
                .font(.largeTitle.bold())
                .foregroundColor(store.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // INPUT FIELD
            VStack(alignment: .leading, spacing: 8) {
                Text("Budget Amount")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(store.textColor.opacity(0.7))
                    .textCase(.uppercase)
                    .tracking(0.5)
                
                HStack {
                    Text("$")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color("Primary"))
                    
                    TextField("0", text: $tempBudget)
                        .font(.title2)
                        .foregroundColor(store.textColor)
                        .keyboardType(.decimalPad)
                        .tint(Color("Accent"))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(store.textColor.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("Primary").opacity(0.3), lineWidth: 1)
                        )
                )
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // SAVE BUTTON
            Button(action: {
                if let value = Double(tempBudget) {
                    monthlyBudget = abs(value)
                }
                dismiss()
            }) {
                Text("Save Budget")
                    .font(.headline)
                    .foregroundColor(Color("TextPrimary"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(saveButtonBackground)
            }
            .disabled(!isInputValid)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(store.backgroundColor.ignoresSafeArea())
        .onAppear {
            tempBudget = String(format: "%.0f", monthlyBudget)
        }
    }
}

#Preview {
    BudgetInputSheet(monthlyBudget: .constant(1500))
        .environmentObject(ExpenseStore())
}
