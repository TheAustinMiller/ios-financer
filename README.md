Financer — Personal Expense Tracking App
Financer is a clean, modern iOS application built with SwiftUI, designed to help users track their daily expenses, visualize spending patterns, and maintain financial clarity. The application emphasizes simplicity, privacy, and beautiful data presentation through interactive charts.
Features
🧾 Expense Management
Add, edit, and delete expenses with an intuitive input form
Categorize purchases using predefined, color-coded categories
View detailed breakdowns by date, amount, and category
Persistent local storage using AppStorage / Codable
📊 Interactive Analytics
Monthly Category Pie Chart
Displays spending proportions grouped by category
Gracefully handles empty data with an informative placeholder
Weekly Bar Chart
Shows daily totals for the current week
Includes an empty-state graph display
Monthly Line Chart
Visualizes spending trends throughout the current month
Includes a fallback visual when no data is present
🎨 Customization
Built-in dark/light mode adaptation
Custom theme colors
Settings menu featuring:
“Clear All Expenses” destructive action with confirmation dialog
Additional personalization options
🚀 Launch Screen & App Icon
Custom splash logo using a Launch Screen storyboard
Scaled vector assets for clean display across devices
Full set of app icons in all required iOS resolutions
Technical Implementation
Core Technologies
SwiftUI (iOS 17+)
Charts Framework
(SectorMark, BarMark, LineMark)
Codable + UserDefaults for lightweight persistence
MVVM-inspired architecture for clean state management
Key Components
ExpenseStore
Central source of truth containing all expense data and computed chart summaries
AddExpenseFormView
Form for adding and editing expense entries
CategoryPieChartView, WeeklyBarChartView, MonthlyLineChartView
Visual analytics views with empty-state fallbacks
SettingsView
Customizable options including destructive confirmation dialogs
Project Structure
Financer/
│
├── Models/
│   ├── Expense.swift
│   └── ExpenseCategory.swift
│
├── ViewModels/
│   └── ExpenseStore.swift
│
├── Views/
│   ├── HomeView.swift
│   ├── AddExpenseFormView.swift
│   ├── ExpenseRowView.swift
│   ├── CategoryPieChartView.swift
│   ├── WeeklyBarChartView.swift
│   ├── MonthlyLineChartView.swift
│   └── SettingsView.swift
│
├── Resources/
│   ├── Assets.xcassets
│   └── LaunchScreen.storyboard
│
└── FinancerApp.swift
How to Build
Clone the repository:
git clone https://github.com/yourusername/Financer.git
Open in Xcode:
open Financer.xcodeproj
Build & run on iOS 17 or later.
Planned Enhancements
CloudKit or iCloud syncing
Budget goals and monthly limits
Exporting expenses to CSV or PDF
Widgets for quick-view statistics
Multi-currency support
FaceID / passcode lock screen
License
This project is released under the MIT License, granting broad rights to modify and distribute while providing liability protection.
Acknowledgments
The application is built with care using SwiftUI’s latest APIs and emphasizes thoughtful UI design, clarity, and user empowerment.
