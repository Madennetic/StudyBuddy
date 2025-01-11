import SwiftUI

struct LoginPage: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var universityProgram: String = ""
    @State private var courses: String = ""
    @State private var showStopwatchPage: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Study Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                TextField("Full Name", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("Email Address", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                
                TextField("University Program", text: $universityProgram)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("Courses (comma-separated)", text: $courses)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                NavigationLink(
                    destination: StopwatchPage(),
                    isActive: $showStopwatchPage
                ) {
                    Button(action: {
                        if !fullName.isEmpty && !email.isEmpty && !universityProgram.isEmpty && !courses.isEmpty {
                            showStopwatchPage = true
                        }
                    }) {
                        Text("Start Studying")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

