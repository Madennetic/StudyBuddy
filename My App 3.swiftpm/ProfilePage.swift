import SwiftUI
import SwiftData

struct ProfilePage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User] // Fetch all users from the database

    var body: some View {
        VStack {
            Text("User Profiles")
                .font(.largeTitle)
                .padding()

            List(users) { user in
                VStack(alignment: .leading) {
                    Text("Full Name: \(user.fullName)")
                    Text("Username: \(user.username)")
                }
                .padding()
            }

            Spacer()
        }
        .padding()
    }
}
