import SwiftUI

struct ExplorePage: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("My Buddies")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()

                    // Example Content
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Studying Buddies")
                            .font(.headline)
                            .padding(.bottom, 5)

                        ForEach(["Sepanta, 1JC3, Mills", "Maden, 1XC3, PG", "Julien, 1PO3, HSL", "Felix, 1BO3, Thode" , "Luca , 1AO6, MUSC"], id: \.self) { course in
                            Text("• \(course)")
                                .font(.body)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    
                    VStack(spacing: 20) {
                        Text("Find Buddies")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .frame(maxWidth: 200)
                    .frame(maxHeight: 75)
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 4)
                }
                .padding()
            }
            .navigationTitle("")
        }
    }
}

#Preview {
    ExplorePage()
}
