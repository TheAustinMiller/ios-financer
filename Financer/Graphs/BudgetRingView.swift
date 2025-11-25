//
//  BudgetRingView.swift
//  Financer
//
//  Created by Big Guy on 11/25/25.
//

import SwiftUI

struct BudgetRingView: View {
    var spent: Double
    var budget: Double

    var progress: Double { min(spent / budget, 1.0) }

    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(
                    Color.white.opacity(0.15),
                    lineWidth: 22
                )

            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        colors: [Color("Primary"), Color("Accent")],
                        center: .center
                    ),
                    style: StrokeStyle(
                        lineWidth: 22,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))

            // Center text
            VStack(spacing: 6) {
                Text("$\(Int(spent))")
                    .font(.system(size: 40, weight: .bold))

                Text("of $\(Int(budget))")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 220, height: 220)
        .padding()
    }
}


#Preview {
    BudgetRingView(spent: 100, budget: 200)
}

