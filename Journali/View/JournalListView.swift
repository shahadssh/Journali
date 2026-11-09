import SwiftUI

struct JournalListView: View {
    @State private var viewModel = JournalViewModel()
    @State private var showEditor = false
    @State private var selectedEntry: JournalEntry?

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.entries.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.displayedEntries) { entry in
                            JournalRowView(entry: entry) {
                                viewModel.toggleBookmark(entry)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                selectedEntry = entry
                                showEditor = true
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    viewModel.entryToDelete = entry
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Journal")
            .searchable(text: $viewModel.searchText)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Sort by Bookmark") { viewModel.sortOption = .bookmark }
                        Button("Sort by Entry Date") { viewModel.sortOption = .entryDate }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        selectedEntry = nil
                        showEditor = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showEditor) {
                EditJournalView(entry: selectedEntry) { saved in
                    viewModel.saveEntry(saved)
                }
            }
            .alert("Delete Journal?",
                   isPresented: Binding(
                    get: { viewModel.entryToDelete != nil },
                    set: { if !$0 { viewModel.entryToDelete = nil } })
            ) {
                Button("Cancel", role: .cancel) { viewModel.entryToDelete = nil }
                Button("Delete", role: .destructive) { viewModel.confirmDelete() }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    JournalListView()
}
