<div align="center">

# **Financer — Personal Expense Tracking App**
A clean, modern iOS application built with **SwiftUI** to help users track expenses, visualize spending patterns, and maintain financial clarity.

</div>

---

## ✨ Features

### 🧾 **Expense Management**
- Add, edit, and delete expenses with an intuitive form  
- Categorize purchases with predefined, color-coded categories  
- View detailed breakdowns by date, amount, and category  
- Persistent local storage using **AppStorage + Codable**

### 📊 **Interactive Analytics**
#### **Monthly Category Pie Chart**
- Displays category-based spending proportions  
- Informative empty-state placeholder

#### **Weekly Bar Chart**
- Shows daily totals for the current week  
- Includes an empty-state graph

#### **Monthly Line Chart**
- Visualizes spending trends across the current month  
- Fallback visual when no data is available

### 🎨 **Customization**
- Full dark/light mode support  
- Custom theme color palette  
- **Settings** menu featuring:
  - “Clear All Expenses” destructive action with confirmation  
  - Additional personalization options  

### 🚀 **Launch Screen & App Icon**
- Custom splash logo using a Launch Screen storyboard  
- Scaled vector assets for crisp display  
- Full set of iOS app icons in all required resolutions  

---

## 🛠️ Technical Implementation

### **Core Technologies**
- **SwiftUI (iOS 17+)**
- **Charts Framework**  
  *(SectorMark, BarMark, LineMark)*
- **Codable + UserDefaults** for lightweight persistence  
- **MVVM-inspired architecture** for clean state management  

### **Key Components**
- **ExpenseStore** — unified data source & chart computation  
- **AddExpenseFormView** — add/edit form UI  
- **CategoryPieChartView, WeeklyBarChartView, MonthlyLineChartView** — analytics visuals with empty-state fallbacks  
- **SettingsView** — customization + confirmation dialogs  

---

## 📌 Planned Enhancements
- CloudKit / iCloud syncing  
- Budget goals & monthly limits  
- Export expenses to CSV or PDF  
- Widgets for quick-view stats  
- Multi-currency support  
- FaceID / passcode lock screen  

---

## 📄 License
This project is available under the **MIT License**, granting broad rights to modify and distribute while providing liability protection.

---

<div align="center">

### 💛 Acknowledgments
Built with care using the latest SwiftUI APIs, focusing on clarity, thoughtful UI, and empowering users to take control of their financial wellbeing.

</div>
