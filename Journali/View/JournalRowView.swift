import SwiftUI

struct JournalRowView: View {
    let entry: JournalEntry
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(entry.title)
                    .font(.headline)
                    .foregroundStyle(Color(red: 0.62, green: 0.56, blue: 1.0))
                Spacer()
                Button(action: onBookmark) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color(red: 0.62, green: 0.56, blue: 1.0))
                }
                .buttonStyle(.plain)
            }
            Text(entry.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                .font(.caption2)
                .foregroundStyle(.gray)
            Text(entry.content)
                .font(.caption)
                .foregroundStyle(.white)
                .lineLimit(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))
    }
}
#Preview {
    JournalRowView(
        entry: JournalEntry(title: "My Birthday",
                            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
                            date: Date(),
                            isBookmarked: true),
        onBookmark: { }
    )
    .padding()
    .preferredColorScheme(.dark)
}
