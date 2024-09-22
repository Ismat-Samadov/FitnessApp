import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var successMessage = ""
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                APIService.shared.registerUser(username: username, password: password, email: email) { result in
                    switch result {
                    case .success(_):  // Replace 'let message' with '_'
                        self.successMessage = "Registration successful!"
                        self.errorMessage = ""
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        self.successMessage = ""
                    }
                }
            }) {
                Text("Register")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            if !successMessage.isEmpty {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }

            if !errorMessage.isEmpty {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}
