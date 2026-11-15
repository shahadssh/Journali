import SwiftUI

struct MainPageView: View {

    @State private var viewModel = JournalViewModel()
    @State private var showEditor = false
    @State private var selectedEntry: JournalEntry?

    var body: some View {
        NavigationStack {
            ZStack {
//                Color("MainScreenBackgroundColor")
//                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    HeaderView(viewModel: viewModel) {
                        selectedEntry = nil
                        showEditor = true
                    }

                    if viewModel.entries.isEmpty {
                        EmptyStateView()
                    } else {
                         List {
                            ForEach(viewModel.displayedEntries) { entry in
                                Button {
                                    selectedEntry = entry
                                    showEditor = true
                                } label: {
                                    JournalRowView(entry: entry) {
                                        viewModel.toggleBookmark(entry)
                                    }
                                }
                                .buttonStyle(.plain)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button {
                                        viewModel.entryToDelete = entry
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                    .tint(Color("Delete action Color"))
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .contentMargins(.bottom, 80, for: .scrollContent)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .contentMargins(.bottom, 80, for: .scrollContent)
                    }
                }

                VStack {
                    Spacer()
                    SearchBarView(viewModel: viewModel)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
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
    MainPageView()
}
