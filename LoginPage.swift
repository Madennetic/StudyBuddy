import SwiftUI

struct LoginPage: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var universityProgram: String = ""
    @State private var currentCourse: String = ""
    @State private var courses: [String] = []
    @State private var showStopwatchPage: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to Study Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // Full Name Entry
                TextField("Full Name", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Email Entry
                TextField("Email Address", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                
                // University Program Entry
                TextField("University Program", text: $universityProgram)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Course Input with Add Button
                HStack {
                    TextField("Add a Course", text: $currentCourse)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        addCourse()
                    }) {
                        Image(systemName: "plus")
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                
                // Display List of Added Courses
                List(courses, id: \.self) { course in
                    Text(course)
                }
                .frame(maxHeight: 200) // Restrict height for better layout
                
                // Navigation Button to StopwatchPage
                NavigationLink(
                    destination: StopwatchPage(courses: courses),
                    isActive: $showStopwatchPage
                ) {
                    Button(action: {
                        if canProceed() {
                            clearInputs()
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
    
    /// Add a course to the list
    private func addCourse() {
        let trimmedCourse = currentCourse.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedCourse.isEmpty {
            courses.append(trimmedCourse)
            currentCourse = "" // Clear the current course input
        }
    }
    
    /// Clear input fields
    private func clearInputs() {
        fullName = ""
        email = ""
        universityProgram = ""
        courses = [] // Optional: Clear courses too, if required
    }
    
    /// Check if user can proceed to next page
    private func canProceed() -> Bool {
        return !fullName.isEmpty && !email.isEmpty && !universityProgram.isEmpty && !courses.isEmpty
    }
}

