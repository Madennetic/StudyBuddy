import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isLoggedIn = false // Track if the user is logged in
    
    var body: some View {
        if isLoggedIn {
            // Show the TabView if logged in
            TabView {
                CoursesPage()
                    .tabItem {
                        Label("Courses", systemImage: "person.fill")
                    }
                
                StopwatchPage()
                    .tabItem {
                        Label("Stopwatch", systemImage: "timer")
                    }
                
                ProfilePage()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
                
                ExplorePage() // Add the new ExplorePage
                    .tabItem {
                        Label("My Buddies", systemImage: "globe")
                    }
            }
        } else {
            // Show the login page if not logged in
            LoginPage(isLoggedIn: $isLoggedIn) // Pass the binding to the LoginPage
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true) // Preview with in-memory storage
}
