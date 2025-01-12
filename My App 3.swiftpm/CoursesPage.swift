import SwiftUI
import SwiftData

struct CoursesPage: View {
    @State private var courses: [String] = [] // List of all courses
    @State private var newCourse: String = "" // Input text

    var body: some View {
        VStack {
            // List of courses with delete functionality
            List {
                ForEach(courses, id: \.self) { course in
                    Text(course)
                }
                .onDelete(perform: removeCourses)
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
                    addCourse()
                }
                .disabled(!isCourseValid())
            }
            .padding()
        }
    }
    
    // Add course to the list
    private func addCourse() {
        courses.append(newCourse)
        newCourse = "" // Clear the text field
    }
    
    // Remove courses
    private func removeCourses(at offsets: IndexSet) {
        courses.remove(atOffsets: offsets)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
