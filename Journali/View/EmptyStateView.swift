import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("Illustration")
                .resizable()
                .scaledToFit()
                .frame(width: 151.39, height: 97.32)

            Text("Begin Your Journal")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color("JournalTitles&EmptyStateHeadingColor"))
                .padding(.top, 28.62)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 18, weight: .light))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("MainHeadings&JournalContentColor"))
                .padding(.top, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView()
}














