import SwiftUI
import SwiftData

struct LoginPage: View {
    @Binding var isLoggedIn: Bool
    @State private var fullName: String = ""
    @State private var userName: String = ""
    @State private var showCoursesPage: Bool = false
    
    // Access the SwiftData context
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // App Title Section
                VStack {
                    Text("Welcome to")
                        .font(.title)
                        .foregroundColor(.gray)
                    Text("Study Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 20)
                
                // Input Fields
                VStack(spacing: 15) {
                    TextField("Full Name", text: $fullName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                        )
                    
                    TextField("Username", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                
                // Navigation Button with Validation
                NavigationLink(
                    destination: StopwatchPage(),
                    isActive: $showCoursesPage
                ) {
                    Button(action: {
                        if !fullName.isEmpty && !userName.isEmpty {
                            saveUser() // Save user data
                            showCoursesPage = true
                            isLoggedIn = true
                        }
                    }) {
                        Text("Start Studying")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(fullName.isEmpty || userName.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                }
                .padding(.horizontal)
                .disabled(fullName.isEmpty || userName.isEmpty) // Disable if inputs are empty
                
                Spacer()
                
                // Footer
                Text("Track your study sessions effortlessly!")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                               startPoint: .top, endPoint: .bottom)
            )
        }
    }
    
    // Save user data into SwiftData
    private func saveUser() {
        let newUser = User(username: userName, fullName: fullName)
        modelContext.insert(newUser) // Add the user to the context
        
        // Force a save to commit changes
        do {
            try modelContext.save()
            print("User saved successfully: \(fullName), \(userName)")
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
}
