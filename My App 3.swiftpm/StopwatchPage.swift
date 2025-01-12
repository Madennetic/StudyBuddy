import SwiftUI
struct StopwatchPage: View {
    @State private var isStudying: Bool = false
    @State private var studyTime: TimeInterval = 0
    @State private var startTime: Date?
    @State private var courses: String = ""
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Study Stopwatch")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Total Study Time: \(formatTime(studyTime))")
                .font(.title2)
            
            Button(action: {
                if isStudying {
                    // Stop studying
                    if let startTime = startTime {
                        studyTime += Date().timeIntervalSince(startTime)
                    }
                    isStudying = false
                } else {
                    // Start studying
                    startTime = Date()
                    isStudying = true
                }
            }) {
                Text(isStudying ? "Stop Studying" : "Start Studying")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isStudying ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .onReceive(timer) { _ in
            if isStudying, let startTime = startTime {
                studyTime = Date().timeIntervalSince(startTime)
            }
        }
        TextField("Course Code", text: $courses)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            .frame(width: 200)
            .multilineTextAlignment(.center)
        
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
