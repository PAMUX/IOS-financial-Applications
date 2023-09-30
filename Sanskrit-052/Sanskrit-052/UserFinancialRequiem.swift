import SwiftUI
import FirebaseFirestore

struct UserFinancialRequiem: View {
    @State private var monthlyIncome = ""
    @State private var expectedExpenses = ""
    @State private var fullName = ""
    @State private var isNavigatingToHomepage = false
    var db = Firestore.firestore()
    
    
    private var savings: Double {
        let income = Double(monthlyIncome) ?? 0
        let expenses = Double(expectedExpenses) ?? 0
        return income - expenses
    }
    
  
    private func backgroundColor() -> Color {
        let percentage = (savings / (Double(monthlyIncome) ?? 1)) * 100
        
        if percentage >= 50 {
            return Color.green
        } else if percentage >= 30 {
            return Color.yellow
        } else if percentage >= 15 {
            return Color.orange
        } else if percentage >= 0 {
            return Color.red
        } else {
            return Color.black
        }
    }
    
    
    private func savingsPercentageImageName() -> String {
        let percentage = (savings / (Double(monthlyIncome) ?? 1)) * 100
        
        if percentage >= 50 {
            return "image4"
        } else if percentage >= 30 {
            return "image3"
        } else if percentage >= 15 {
            return "image2"
        } else if percentage >= 0 {
            return "image1"
        } else {
            return "image0"
        }
    }
    
    var body: some View {
        VStack {
            Text((fullName))
                .font(.title)
                .padding()
            
            
            TextField("Monthly Income", text: $monthlyIncome)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(Color.black.opacity(0.7), lineWidth: 2))
                .padding(.top, 10)
            
            TextField("Expected Expenses", text: $expectedExpenses)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(Color.black.opacity(0.7), lineWidth: 2))
                .padding(.top, 10)
            
            
            VStack {
                
                Image(savingsPercentageImageName())
                    .resizable()
                    .frame(width: 250, height: 250)
                    .opacity(100)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor())
                    .shadow(radius: 5)
            )
            .padding(.top, 60)
            
           
            Text("Savings: \(savings, specifier: "%.2f")")
                .foregroundColor(savings >= 0 ? Color.black : Color.black)
                .font(.title)
                .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                // Save data to Firestore
                if !userUID.isEmpty {
                    let userDocument = self.db.collection("User-profile").document(userUID)
                    userDocument.updateData([
                        "Monthly Income": Double(self.monthlyIncome) ?? 0,
                        "Expected Expenses": Double(self.expectedExpenses) ?? 0,
                        "Savings Percentage Image": self.savingsPercentageImageName()
                                         
                        
                        
                    ]) { error in
                        if let error = error {
                            print("Error updating document: \(error)")
                        } else {
                            print("Document updated successfully!")
                            
                            self.isNavigatingToHomepage = true
                        }
                    }
                }
            }) {
                Text("Next")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(30)
            }
            .padding(.top, 20)
            
            
            NavigationLink(
                destination: Homepage(),
                isActive: $isNavigatingToHomepage
            ) {
                EmptyView()
            }
        }
        .padding(.horizontal, 25)
        .navigationBarBackButtonHidden(true)
    }
}
