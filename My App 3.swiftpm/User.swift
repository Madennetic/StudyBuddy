import SwiftData

@Model
class User {
    @Attribute(.unique) var username: String
    var fullName: String
    
    init(username: String, fullName: String) {
        self.username = username
        self.fullName = fullName
    }
}
