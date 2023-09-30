//
//  ContentView.swift
//  Sanskrit-052
//
//  Created by Maleesha Wijeratne on 22/09/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore


struct ContentView: View {
    var body: some View {
        NavigationView {
                   Home()
               }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    var body: some View {
        Login()
    }
}

struct Login: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var isPasswordVisible = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isAuthenticated = false
    
    var body: some View {
        VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreateAccount()) { 
                            Text("Create Account")
                                .font(.headline)
                                .foregroundColor(Color.orange)
                                .padding(.top, 10)
                        }
                    }
            Image("coin")
                .resizable()
                .frame(width: 300, height: 300)
            
            Text("Log in to your account")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(self.color)
                .padding(.top, 5)
            
            TextField("Email", text: self.$email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.email.isEmpty ? Color("Color") : self.color, lineWidth: 2))
                .padding(.top, 25)
            
            HStack {
                if isPasswordVisible {
                    TextField("Password", text: self.$password)
                } else {
                    SecureField("Password", text: self.$password)
                }
                
                Button(action: {
                    self.isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.color)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.password.isEmpty ? Color("Color") : self.color, lineWidth: 2))
            .padding(.top, 10)
            
            NavigationLink("", destination: Homepage(), isActive: $isAuthenticated)

                   Button(action: {
                       Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                           if let error = error {
                            
                               self.alertMessage = error.localizedDescription
                               self.showingAlert = true
                           } else {
                               
                               self.isAuthenticated = true 
                           }
                       }
                   }) {
                       Text("Submit")
                           .font(.title)
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.orange)
                           .cornerRadius(30)
                   }
                   .padding(.top, 25)
               }
               .padding(.horizontal, 25)
               .alert(isPresented: $showingAlert) {
                   Alert(
                       title: Text("Error"),
                       message: Text(alertMessage),
                       dismissButton: .default(Text("OK"))
                   )
               }
           }
       }
