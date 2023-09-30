import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase

struct CreateAccount: View {
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var fullName = ""
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    @State private var isAccountCreated = false
    
    var db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("wallet")
                    .resizable()
                    .frame(width: 300, height: 300)

                TextField("Full Name", text: self.$fullName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.fullName.isEmpty ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2))
                    .padding(.top, 25)

                TextField("Email address", text: self.$username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.username.isEmpty ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2))
                    .padding(.top, 10)

                TextField("Password", text: self.$password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password.isEmpty ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2))
                    .padding(.top, 10)

                TextField("Confirm Password", text: self.$confirmPassword)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.confirmPassword.isEmpty ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2))
                    .padding(.top, 10)

                Button(action: {
                    // Validate passwords
                    if self.password == self.confirmPassword {
                        Auth.auth().createUser(withEmail: self.username, password: self.password) { authResult, error in
                            if let error = error {
                                self.alertMessage = error.localizedDescription
                                self.isShowingAlert = true
                            } else {
                                
                                self.alertMessage = ""
                                
                              
                                self.isAccountCreated = true
                                
                              
                                if let user = authResult?.user {
                                    userUID = user.uid
                                    
                                  
                                    let accountCreationDate = Date()
                                    
                                    let userDocument = self.db.collection("User-profile").document(userUID)
                                    userDocument.setData([
                                        "Full Name": self.fullName,
                                        "User UID": userUID,
                                        "Account Creation Date": accountCreationDate
                                    ]) { error in
                                        if let error = error {
                                            print("Error writing document: \(error)")
                                        } else {
                                            print("Document successfully written!")
                                           
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        self.alertMessage = "Passwords do not match"
                        self.isShowingAlert = true
                    }
                }) {
                    Text("Create New Wallet")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(30)
                }
                .padding(.top, 25)
                
               
                NavigationLink(destination: UserFinancialRequiem(), isActive: $isAccountCreated) {
                    EmptyView()
                }
            }
            .padding(.horizontal, 25)
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

               struct CreateAccount_Previews: PreviewProvider {
                   static var previews: some View {
                       CreateAccount()
                   }
               }
