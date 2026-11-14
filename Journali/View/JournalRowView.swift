import SwiftUI

struct JournalRowView: View {
    let entry: JournalEntry
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Text(entry.title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color("JournalTitles&EmptyStateHeadingColor"))
                Spacer()
                Button(action: onBookmark) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24))
                        .foregroundStyle(Color("JournalTitles&EmptyStateHeadingColor"))
                }
                .buttonStyle(.plain)
            }

            Text(entry.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                .font(.system(size: 14))
                .foregroundStyle(Color("Entry dates Color"))
                .padding(.top, 4)

            Text(entry.content)
                .font(.system(size: 18))
                .foregroundStyle(Color("MainHeadings&JournalContentColor"))
                .lineLimit(4)
                .padding(.top, 16)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("Journal cards Color"), in: RoundedRectangle(cornerRadius: 28))
    }
}
