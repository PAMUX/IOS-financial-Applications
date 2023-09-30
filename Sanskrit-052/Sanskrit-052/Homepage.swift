import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct Homepage: View {
    @State private var userName = "Loading..."
    @State private var iconArray = ["Himg1", "Himg2", "Himg3", "Himg3"]
    var arrayText = ["Tracking", "Budgeting", "Analytics", "Profile"]
    var db = Firestore.firestore()

    var body: some View {
        NavigationView {
            VStack {
                  Text(userName)
                    .font(.headline)
                    .padding()
                
               
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                    ForEach(0..<iconArray.count) { index in
                        NavigationLink(destination: destinationForIndex(index)) {
                            VStack {
                                Image(iconArray[index])
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                Text(arrayText[index])
                                    .font(.headline)
                                    .padding()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                Spacer()
                
                // Display a bottom image
                Image("Welcome")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                fetchUserName()
            }
        }
    }

    private func fetchUserName() {
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("User-profile").document(user.uid)
            userDocument.getDocument { document, error in
                if let document = document, document.exists {
                    if let fullName = document["Full Name"] as? String {
                        self.userName = fullName
                    }
                    
                    if let savingsPercentageImage = document["Savings Percentage Image"] as? String {
                       
                        self.iconArray[3] = savingsPercentageImage
                    }
                }
            }
        }
    }

    private func destinationForIndex(_ index: Int) -> some View {
        switch arrayText[index] {
        case "Tracking":
            return AnyView(Tracking())
        case "Budgeting":
            return AnyView(BudgetSettingView())
        case "Analytics":
            return AnyView(Analytics())
        case "Profile":
            return AnyView(ProfileView())
        default:
            return AnyView(EmptyView())
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
            .navigationBarBackButtonHidden(true)
    }
}
