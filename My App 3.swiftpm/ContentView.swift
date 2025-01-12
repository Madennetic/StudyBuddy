import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            LoginPage()
                .tabItem {
                    Label("Login", systemImage: "person.fill")
                }
            
            StopwatchPage()
                .tabItem {
                    Label("Stopwatch", systemImage: "timer")
                }
            
            ProfilePage()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true) // Preview with in-memory storage
}
