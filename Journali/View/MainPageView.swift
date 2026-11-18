import SwiftUI

struct MainPageView: View {
    
    @State private var viewModel = JournalViewModel()
    @State private var showEditor = false
    @State private var selectedEntry: JournalEntry?
    
    var body: some View {
        NavigationStack {
            ZStack {
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
            .overlay {
                if viewModel.entryToDelete != nil {
                    ZStack {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                            .onTapGesture { viewModel.entryToDelete = nil }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Delete Journal?")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            Text("Are you sure you want to delete this journal?")
                                .font(.system(size: 17))
                                .foregroundStyle(.white.opacity(0.85))
                                .padding(.bottom, 8)
                            
                            HStack(spacing: 12) {
                                Button {
                                    viewModel.entryToDelete = nil
                                } label: {
                                    Text("Cancel")
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 52)
                                        .background(Color.white.opacity(0.15), in: Capsule())
                                }
                                
                                Button {
                                    viewModel.confirmDelete()
                                } label: {
                                    Text("Delete")
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 52)
                                        .background(Color("Delete action Color"), in: Capsule())
                                }
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: 320)
                        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 36))
                        .padding(.horizontal, 24)
                        .transition(.scale(scale: 0.9).combined(with: .opacity))
                    }
                }
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.entryToDelete != nil)
        }
    }
}

#Preview {
    MainPageView()
}
