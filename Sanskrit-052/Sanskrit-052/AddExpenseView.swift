//
//  AddExpenseView.swift
//  Sanskrit-052
//
//  Created by Maleesha Wijeratne on 24/09/2023.
//

import SwiftUI
struct AddExpenseView: View {
    @State private var date = Date()
    @State private var category = ""
    @State private var amount = ""
    @State private var description = ""
    @State private var location = ""
    @Binding var expenses: [Expense]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Expense Details")) {
                    DatePicker("Date", selection: $date)
                    TextField("Category", text: $category)
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                    TextField("Description", text: $description)
                    TextField("Location", text: $location)
                }

                Section {
                    Button("Save Expense") {
                        if let amount = Double(amount) {
                            let newExpense = Expense(date: date, category: category, amount: amount, description: description, location: location)
                            expenses.append(newExpense)
                        }
                    }
                }
            }
            .navigationBarTitle("Add Expense")
        }
    }
}
