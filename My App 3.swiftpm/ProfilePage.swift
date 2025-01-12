import SwiftUI
import SwiftData
import Charts

struct ProfilePage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User] // Fetch the current user
    @State private var currentUser: User? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let user = currentUser {
                    Text("Profile of \(user.fullName)")
                        .font(.largeTitle)
                        .padding(.top)

                    Text("Username: \(user.username)")
                        .font(.headline)

                    Divider()

                    // Courses Section
                    VStack(alignment: .leading) {
                        Text("Courses:")
                            .font(.headline)
                        ForEach(user.courses, id: \.self) { course in
                            Text("- \(course)")
                        }
                    }
                    .padding(.bottom, 10)

                    Divider()

                    // Study Sessions Section
                    VStack(alignment: .leading) {
                        Text("Study Sessions:")
                            .font(.headline)
                        ForEach(user.studySessions, id: \.self) { session in
                            VStack(alignment: .leading) {
                                Text("Course: \(session.courseName)")
                                Text("Time Spent: \(formatTime(session.timeSpent))")
                                Text("Date: \(formatDate(session.date))")
                                    .foregroundColor(.gray)
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    .padding(.bottom, 10)

                    Divider()

                    // Bar Chart for Study Time
                    Chart {
                        ForEach(user.studySessions, id: \.self) { session in
                            BarMark(
                                x: .value("Course", session.courseName),
                                y: .value("Time", session.timeSpent)
                            )
                            .foregroundStyle(Color.blue)
                        }
                    }
                    .chartXAxisLabel("Courses")
                    .chartYAxisLabel("Time Spent (s)")
                    .frame(height: 250)
                   
                } else {
                    Text("No user data available.")
                }
            }
            .padding()
        }
        .onAppear {
            currentUser = users.last
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
