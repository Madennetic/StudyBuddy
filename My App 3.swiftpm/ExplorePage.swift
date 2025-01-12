import SwiftUI

struct ExplorePage: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Explore")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()

                    // Example Content
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Popular Courses")
                            .font(.headline)
                            .padding(.bottom, 5)

                        ForEach(["Course 1", "Course 2", "Course 3"], id: \.self) { course in
                            Text("• \(course)")
                                .font(.body)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding()
            }
            .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExplorePage()
}
