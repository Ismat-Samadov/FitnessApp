import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @Binding var token: String
    @Binding var isLoggedIn: Bool
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                APIService.shared.loginUser(username: username, password: password) { result in
                    switch result {
                    case .success(let token):
                        self.token = token
                        self.isLoggedIn = true
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
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
