//
//  BudgetSettingView.swift
//  Sanskrit-052
//
//  Created by Maleesha Wijeratne on 24/09/2023.
//
import SwiftUI

struct BudgetSettingView: View {
    @State private var selectedTimeFrame = 0
    @State private var categories: [String] = ["Groceries", "Entertainment", "Rent"]
    @State private var budgetAmounts: [String: Double] = [:]
    @State private var isSaving = false

    var timeFrames = ["Monthly", "Weekly"]

    var body: some View {
        VStack {
            Text("Set Budgets")
                .font(.largeTitle)
                .padding(.bottom, 20)

            Picker("Time Frame", selection: $selectedTimeFrame) {
                ForEach(0..<timeFrames.count, id: \.self) { index in
                    Text(timeFrames[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        TextField("Budget Amount", text: Binding<String>(
                            get: { String(format: "%.2f", budgetAmounts[category] ?? 0.0) },
                            set: { newValue in
                                if let amount = Double(newValue) {
                                    budgetAmounts[category] = amount
                                }
                            }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    }
                }
            }

            Button(action: {
                saveBudgets()
            }) {
                Text("Save Budgets")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
            .disabled(isSaving)
        }
        .padding()
    }

    private func saveBudgets() {
       
        isSaving = true

    }
}

struct BudgetSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingView()
    }
}
