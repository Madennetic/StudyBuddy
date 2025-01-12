import SwiftData
import Foundation // Required for Date and related operations

@Model
class User {
    @Attribute(.unique) var username: String // Ensure usernames are unique
    var fullName: String
    var courses: [String] = [] // List of courses added by the user
    var studySessions: [StudySession] = [] // List of study sessions

    // Initializer for User
    init(username: String, fullName: String) {
        self.username = username
        self.fullName = fullName
    }

}

@Model
class StudySession {
    var courseName: String // Name of the course studied
    var timeSpent: TimeInterval // Time spent in seconds
    var date: Date // Date of the study session

    // Initializer for StudySession
    init(courseName: String, timeSpent: TimeInterval, date: Date) {
        self.courseName = courseName
        self.timeSpent = timeSpent
        self.date = date
    }
}
