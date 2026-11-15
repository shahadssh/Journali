import Foundation

struct JournalEntry: Identifiable, Equatable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool = false
}
