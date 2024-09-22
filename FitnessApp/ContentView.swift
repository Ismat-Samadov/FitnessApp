import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var token = ""
    @State private var showingRegisterView = false

    var body: some View {
        VStack {
            if isLoggedIn {
                WorkoutListView(token: token)
            } else {
                if showingRegisterView {
                    RegisterView()
                } else {
                    LoginView(token: $token, isLoggedIn: $isLoggedIn)
                }
            }
            
            // Button to toggle between login and register
            Button(action: {
                showingRegisterView.toggle()
            }) {
                Text(showingRegisterView ? "Already have an account? Login" : "Don't have an account? Register")
                    .padding()
                    .foregroundColor(.blue)
            }
        }
    }
}
