import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "book.pages")
                .font(.system(size: 80))
                .foregroundStyle(Color(red: 0.62, green: 0.56, blue: 1.0))
            Text("Begin Your Journal")
                .font(.headline)
                .foregroundStyle(Color(red: 0.62, green: 0.56, blue: 1.0))
            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.horizontal, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
