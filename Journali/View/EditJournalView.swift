import SwiftUI

struct EditJournalView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var content: String
    @State private var showDiscardAlert = false
    @FocusState private var focusedField: Field?

    private enum Field { case title, content }

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
        VStack(alignment: .leading, spacing: 0) {
            // الأزرار العلوية
            HStack {
                Button {
                    if hasChanges { showDiscardAlert = true } else { dismiss() }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                }
                .glassEffect(.clear, in: Circle())

                Spacer()

                Button {
                    var saved = original
                    saved.title = title
                    saved.content = content
                    onSave(saved)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .background(Color("Save button, active actions Color"), in: Circle())
                }
                .disabled(title.isEmpty)
                .opacity(title.isEmpty ? 0.5 : 1)
            }

            // العنوان
            TextField("", text: $title,
                      prompt: Text("Title").foregroundStyle(.gray))
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
                .focused($focusedField, equals: .title)
                .padding(.top, 20)

            // التاريخ
            Text(original.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                .font(.system(size: 14))
                .foregroundStyle(Color("Entry dates Color"))
                .padding(.top, 8)

            // النص
            TextEditor(text: $content)
                .scrollContentBackground(.hidden)
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .focused($focusedField, equals: .content)
                .overlay(alignment: .topLeading) {
                    if content.isEmpty {
                        Text("Type your Journal...")
                            .font(.system(size: 20))
                            .foregroundStyle(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                    }
                }
                .padding(.top, 16)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .background(Color("Journal cards Color").ignoresSafeArea())
        .presentationDragIndicator(.visible)
        .preferredColorScheme(.dark)
        .onAppear { focusedField = .title }
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
