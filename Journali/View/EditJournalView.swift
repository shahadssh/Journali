import SwiftUI

struct EditJournalView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var content: String
    @State private var showDiscardAlert = false

    private let original: JournalEntry
    let onSave: (JournalEntry) -> Void

    init(entry: JournalEntry? = nil, onSave: @escaping (JournalEntry) -> Void) {
        let base = entry ?? JournalEntry(title: "", content: "", date: Date())
        self.original = base
        self._title = State(initialValue: base.title)
        self._content = State(initialValue: base.content)
        self.onSave = onSave
    }

    private var hasChanges: Bool {
        title != original.title || content != original.content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button {
                    if hasChanges { showDiscardAlert = true } else { dismiss() }
                } label: {
                    Image(systemName: "xmark")
                }
                Spacer()
                Button {
                    var saved = original
                    saved.title = title
                    saved.content = content
                    onSave(saved)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color(red: 0.62, green: 0.56, blue: 1.0))
                }
                .disabled(title.isEmpty)
            }
            .font(.title3)

            TextField("Title", text: $title)
                .font(.title2.bold())

            Text(original.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                .font(.caption)
                .foregroundStyle(.gray)

            TextEditor(text: $content)
                .scrollContentBackground(.hidden)

            Spacer()
        }
        .padding()
        .preferredColorScheme(.dark)
        .confirmationDialog("Are you sure you want to discard changes on this journal?",
                            isPresented: $showDiscardAlert,
                            titleVisibility: .visible) {
            Button("Discard Changes", role: .destructive) { dismiss() }
            Button("Keep Editing", role: .cancel) { }
        }
    }
}
#Preview {
    EditJournalView { _ in }
}
