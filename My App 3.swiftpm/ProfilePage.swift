import SwiftUI
import SwiftData
import Charts

struct ProfilePage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User] // Fetch the current user
    @State private var currentUser: User? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                if let user = currentUser {
                    // Header Section
                    VStack(spacing: 10) {
                        Text("Welcome, \(user.fullName)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)

                        Text("Username: \(user.username)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
                    .frame(maxWidth: .infinity) // Keep it centered in the layout

                    // Combined Courses and Study Sessions Section
                    VStack(alignment: .leading, spacing: 20) {
                        // Courses Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Courses")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)

                            if user.courses.isEmpty {
                                Text("No courses added yet.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } else {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(user.courses, id: \.self) { course in
                                        Text("• \(course)")
                                            .font(.body)
                                    }
                                }
                            }
                        }

                        Divider()

                        // Study Sessions Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Study Sessions")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)

                            if user.studySessions.isEmpty {
                                Text("No study sessions recorded yet.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } else {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(user.studySessions, id: \.self) { session in
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("Course: \(session.courseName)")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)

                                            Text("Time Spent: \(formatTime(session.timeSpent))")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)

                                            Text("Date: \(formatDate(session.date))")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)

                    // Bar Chart Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Study Time Analysis")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)

                        if user.studySessions.isEmpty {
                            Text("No data available for chart.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
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
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                    }

                    .chartXAxisLabel("Courses")
                    .chartYAxisLabel("Time Spent (s)")
                    .frame(height: 250)
                   


                } else {
                    Text("No user data available.")
                        .font(.title3)
                        .foregroundColor(.gray)
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
