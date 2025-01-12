import SwiftUI
import SwiftData

struct StopwatchPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User] // Fetch the current user

    @State private var isStudying: Bool = false
    @State private var studyTime: TimeInterval = 0
    @State private var startTime: Date?
    @State private var selectedCourse: String = ""

    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var currentUser: User? = nil

    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 5) {
                Text("Study Stopwatch")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            
            // Timer Section
            VStack(spacing: 10) {
                Text("Total Study Time")
                    .font(.headline)
                Text("\(formatTime(studyTime))")
                    .font(.system(size: 60, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)

            // Course Picker
            Picker("Select Course", selection: $selectedCourse) {
                ForEach(currentUser?.courses ?? [], id: \.self) { course in
                    Text(course)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            // Start/Stop Button
            Button(action: {
                if isStudying {
                    if let startTime = startTime {
                        studyTime += Date().timeIntervalSince(startTime)
                        saveStudySession()
                    }
                    isStudying = false
                } else {
                    startTime = Date()
                    isStudying = true
                }
            }) {
                Text(isStudying ? "Stop Studying" : "Start Studying")
                    .padding()
                    .background(isStudying ? Color.indigo : Color.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            currentUser = users.first
        }
        .onReceive(timer) { _ in
            if isStudying, let startTime = startTime {
                studyTime = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    private func saveStudySession() {
        guard let user = currentUser, !selectedCourse.isEmpty else { return }

        let newSession = StudySession(courseName: selectedCourse, timeSpent: studyTime, date: Date())
        user.studySessions.append(newSession)
        
        do {
            try modelContext.save()
            print("Study session saved: \(selectedCourse), \(studyTime) seconds on \(Date())")
        } catch {
            print("Failed to save study session: \(error.localizedDescription)")
        }

        studyTime = 0
        selectedCourse = ""
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
