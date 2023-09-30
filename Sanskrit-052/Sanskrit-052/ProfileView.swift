import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var userEmail = ""
    
    var body: some View {
        VStack {
            Text("User Profile")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            Text("Email: \(userEmail)")
                .font(.headline)
                .padding(.bottom, 10)

            
            
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    exit(0)
                } catch {
                    print("Error signing out: \(error.localizedDescription)")
                }
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
           
            if let userEmail = Auth.auth().currentUser?.email {
                self.userEmail = userEmail
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
