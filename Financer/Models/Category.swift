//
//  Category.swift
//  Financer
//
//  Created by Big Guy on 11/20/25.
//
import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable {
    case food = "Food & Drink"
    case transport = "Transport"
    case shopping = "Shopping"
    case health = "Health"
    case entertainment = "Entertainment"
    case bills = "Bills & Utilities"
    case education = "Education"
    case travel = "Travel"
    
    var id: String { rawValue }
    
    var systemImage: String {
        switch self {
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .shopping: return "bag.fill"
        case .health: return "heart.fill"
        case .entertainment: return "tv.fill"
        case .bills: return "bolt.fill"
        case .education: return "book.fill"
        case .travel: return "airplane"
        }
    }
}
