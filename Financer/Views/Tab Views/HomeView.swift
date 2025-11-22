//
//  HomeView.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

struct HomeView: View {
    private var todayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }

    private var today: String {
        todayFormatter.string(from: Date())
    }

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome to Financer")
                    .foregroundColor(Color("TextPrimary"))
                    .font(.largeTitle.bold())
                    .padding(.top, 40)
                
                Text(today)
                    .font(.subheadline)
                    .foregroundColor(Color("TextPrimary").opacity(0.6))
                    .fontWeight(.medium)
                    .transition(.opacity.combined(with: .slide))
                    .animation(.easeInOut(duration: 0.5), value: today)

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
