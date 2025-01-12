import SwiftUI
import SwiftData

struct CoursesPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User] // Fetch the current user

    @State private var newCourse: String = "" // Input text
    @State private var currentUser: User? = nil

    var body: some View {
        VStack {
            if let user = currentUser {
                Text("Courses for \(user.fullName)")
                    .font(.headline)
                    .padding()
                if user.courses.isEmpty {
                    Text("Input courses at the bottom to start")
                        .opacity(0.25)
                }

                // List of courses with delete functionality
                List {
                    ForEach(user.courses, id: \.self) { course in
                        Text(course)
                    }
                    .onDelete { offsets in
                        removeCourses(from: user, at: offsets)
                    }
                }
                
                // TextField for adding new courses
                HStack {
                    TextField("Enter course", text: $newCourse)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: newCourse) { newValue in
                            enforceTextFieldRules(newValue)
                        }
                        .textInputAutocapitalization(.characters)
                        .disableAutocorrection(true)
                    
                    // Add Button
                    Button("Add") {
                        addCourse(to: user)
                    }
                    .disabled(!isCourseValid())
                }
                .padding()
            } else {
                Text("No user logged in.")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            currentUser = users.last
        }
    }
    
    // Add course to the user's list
    private func addCourse(to user: User) {
        user.courses.append(newCourse)
        newCourse = "" // Clear the text field
        saveChanges()
    }
    
    // Remove courses from the user's list
    private func removeCourses(from user: User, at offsets: IndexSet) {
        user.courses.remove(atOffsets: offsets)
        saveChanges()
    }
    
    // Save changes to the SwiftData model
    private func saveChanges() {
        do {
            try modelContext.save()
            print("Changes saved successfully.")
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
    
    // Enforce text field rules
    private func enforceTextFieldRules(_ value: String) {
        if value.count > 4 {
            newCourse = String(value.prefix(4))
        }
    }
    
    // Validate input
    private func isCourseValid() -> Bool {
        newCourse.count == 4 && !newCourse.isEmpty
    }
}
