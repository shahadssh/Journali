import Foundation
import Observation

enum SortOption {
    case entryDate
    case bookmark
}

@Observable
class JournalViewModel {
    var entries: [JournalEntry] = []
    var searchText = ""
    var sortOption: SortOption = .entryDate

    // اليومية اللي المستخدم سحبها للحذف وتنتظر تأكيد (Delete Alert)
    var entryToDelete: JournalEntry?

    var displayedEntries: [JournalEntry] {
        var result = entries

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .entryDate:
            result.sort { $0.date > $1.date }
        case .bookmark:
            result.sort {
                if $0.isBookmarked != $1.isBookmarked { return $0.isBookmarked }
                return $0.date > $1.date
            }
        }
        return result
    }

    func saveEntry(_ entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
        } else {
            entries.append(entry)
        }
    }

    func confirmDelete() {
        guard let entry = entryToDelete else { return }
        entries.removeAll { $0.id == entry.id }
        entryToDelete = nil
    }

    func toggleBookmark(_ entry: JournalEntry) {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[index].isBookmarked.toggle()
    }
}
