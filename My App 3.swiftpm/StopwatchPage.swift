import SwiftUI

struct StopwatchPage: View {
    @State private var isStudying: Bool = false
    @State private var studyTime: TimeInterval = 0
    @State private var startTime: Date?
    @State private var selectedCourses: [String] = [] // Tracks selected courses
    private let courseOptions = ["1B03", "1ZA3", "1JC3", "1DM3"] // Checklist options
    @State private var sessionCourses: [String] = [] // Tracks courses added to the session
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 5) {
                Text("Study Stopwatch")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 5)
                Text("Track your study sessions with ease.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 20)
            
            // Timer Section
            VStack(spacing: 10) {
                Text("Total Study Time")
                    .font(.headline)
                Text("\(formatTime(studyTime))")
                    .font(.system(size: 60, weight: .bold, design: .monospaced)) // Monospaced timer
                    .foregroundColor(.primary)
                    .padding(.vertical, 10)
            }
            .padding(.horizontal)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
            
            // Start/Stop Button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    if isStudying {
                        if let startTime = startTime {
                            studyTime += Date().timeIntervalSince(startTime)
                        }
                        isStudying = false
                    } else {
                        startTime = Date()
                        isStudying = true
                    }
                }
            }) {
                Text(isStudying ? "Stop Studying" : "Start Studying")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isStudying ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: isStudying ? Color.red.opacity(0.4) : Color.green.opacity(0.4), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal)
            
            // Checklist Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Select Courses to Study")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                // Grid layout for the checklist
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                    ForEach(courseOptions, id: \.self) { course in
                        Button(action: {
                            withAnimation {
                                toggleCourseSelection(course: course)
                            }
                        }) {
                            HStack {
                                Image(systemName: selectedCourses.contains(course) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(selectedCourses.contains(course) ? .blue : .gray)
                                Text(course)
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 5)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal)
            
            // Add to Session Button
            Button(action: {
                sessionCourses = selectedCourses
                selectedCourses = []
            }) {
                Text("Change Sessions")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: Color.blue.opacity(0.4), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal)
            
            // Display Session Courses
            if !sessionCourses.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Session Courses")
                        .font(.headline)
                    
                    // Grid layout for session courses
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                        ForEach(sessionCourses, id: \.self) { course in
                            Text(course)
                                .font(.subheadline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
            }
        }
        .padding()
        .onReceive(timer) { _ in
            if isStudying, let startTime = startTime {
                studyTime = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    func toggleCourseSelection(course: String) {
        if selectedCourses.contains(course) {
            selectedCourses.removeAll { $0 == course }
        } else {
            selectedCourses.append(course)
        }
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
