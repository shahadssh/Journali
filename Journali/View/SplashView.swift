import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, Color(red: 0.2, green: 0.15, blue: 0.4)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 8) {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.orange)
                Text("Journali")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Text("Your thoughts, your story")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
}
