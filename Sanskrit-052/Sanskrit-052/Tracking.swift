import SwiftUI

struct Tracking: View {

    @State private var amount = ""
    @State private var description = ""
    @State private var location = ""
    @State private var selectedCategory = "Food" //
    @State private var expenses: [Expense] = []
    let categories = ["Food", "Clothes", "Loans", "Bills", "Rent", "Other"]

    var body: some View {
        VStack {
            TextField("Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Location", text: $location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

             Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Button(action: {
                addExpense()
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

           
                       List(expenses, id: \.id) { expense in
                           HStack {
                               Text(expense.description)
                               Spacer()
                               Text(String(format: "%.2f", expense.amount))
                               Spacer()
                               Text(expense.category)
                           }
                       }
                       .padding()
                   }
                   .padding()
                   .navigationBarBackButtonHidden(false)
               }
    // Function to add an expense to the list
    private func addExpense() {
        guard let amountDouble = Double(amount) else { return }
        let newExpense = Expense(amount: amountDouble, description: description, location: location, category: selectedCategory)
        expenses.append(newExpense)

        
        amount = ""
        description = ""
        location = ""
        selectedCategory = "Food" 
    }
}

struct Tracking_Previews: PreviewProvider {
    static var previews: some View {
        Tracking()
        
        
        
    }
}

