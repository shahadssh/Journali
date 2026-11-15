import Foundation
import Observation

enum SortOption {
    case entryDate
    case bookmark
}

@Observable
class JournalViewModel {
    var entries: [JournalEntry] = [] {
        didSet { save() }
    }
    var searchText = ""
    var sortOption: SortOption = .entryDate
    var showBookmarkedOnly = false
    var entryToDelete: JournalEntry?

    
    @ObservationIgnored
    private let saveURL = URL.documentsDirectory.appending(path: "journals.json")

    init() {
        load()
    }

    var displayedEntries: [JournalEntry] {
        var result = entries

        // فلتر الـ bookmark
        if showBookmarkedOnly {
            result = result.filter { $0.isBookmarked }
        }

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        result.sort { $0.date > $1.date }   // الترتيب دايمًا حسب التاريخ
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

    private func save() {
        if let data = try? JSONEncoder().encode(entries) {
            try? data.write(to: saveURL, options: .atomic)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: saveURL),
              let decoded = try? JSONDecoder().decode([JournalEntry].self, from: data)
        else { return }
        entries = decoded
    }
}
