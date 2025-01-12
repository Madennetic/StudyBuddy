import SwiftUI

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
