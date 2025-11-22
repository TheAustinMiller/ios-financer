//
//  FinancerApp.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//

import SwiftUI

@main
struct FinancerApp: App {
    @StateObject var store = ExpenseStore()

    var body: some Scene {
        WindowGroup {
            FinancerAppView()
                .tint(Color("Primary"))
                .environmentObject(store)
        }
    }
}
