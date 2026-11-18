import Foundation //basic lib.
import Observation // new lib. that OBSERVES data and update it automatically

enum SortFilter { // a "list" or actually "enumarator" named SortFilter
    case entryDate
    case bookmark     }


@Observable //this class is observed
class JournalViewModel { // it's a class because we want a ONE version+its in VM
  
    var entries: [JournalEntry] = [] { //empty array
       
        didSet { save() } // didSet is a Swift property observer that runs code immediately after a property's value is changed
    }
    
    var searchText = ""
    var sortFilter: SortFilter = .entryDate
    var entryToDelete: JournalEntry? // ? is making the var optional
    
    @ObservationIgnored
    private let saveURL = URL.documentsDirectory.appending(path: "journals.json") //JavaScript Object Notation
    
    init() { //initializer swift func
        load() // load and show files in json
    }

    var displayedEntries: [JournalEntry] { //added all in one array to give the user the ability to serch from bookmarks
        var result = entries

        // the bookmark filter
        if sortFilter == .bookmark {
            result = result.filter { $0.isBookmarked } // $0 this chosen index aka entry
            // . read from this property
            // isBookmarked true or false
        }

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
               
                || //or
                
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        result.sort { $0.date > $1.date }   // date from newest to oldest
        return result
    }
    func saveEntry(_ entry: JournalEntry) { //saved in RAM
        if let index = entries.firstIndex(where:
        { $0.id == entry.id }) {  //entry is already there then edit it
            entries[index] = entry
        } else {
            entries.append(entry) // if new entry the add it
        }
    }

    func confirmDelete() { //
        guard let entry = entryToDelete else { return }
        entries.removeAll { $0.id == entry.id }
        entryToDelete = nil
    }

    func toggleBookmark(_ entry: JournalEntry) {
        guard let index = entries.firstIndex(where:
        { $0.id == entry.id }) else { return }
        entries[index].isBookmarked.toggle()
    }

    private func save() { //chech RAM then saved in device memory
        if let data = try? JSONEncoder().encode(entries) {
            try? data.write(to: saveURL, options: .atomic)
        }
    }

    private func load() { //load from from device memory to RAM
        guard let data = try? Data(contentsOf: saveURL),
              let decoded = try? JSONDecoder().decode([JournalEntry].self, from: data)
        else { return }
        entries = decoded
    }
}
