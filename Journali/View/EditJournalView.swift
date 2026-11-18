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

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                .disabled(!canSave)
                .opacity(canSave ? 1 : 0.5)
            }

            TextField("", text: $title,
                      prompt: Text("Title").foregroundStyle(.gray))
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
                .focused($focusedField, equals: .title)
                .padding(.top, 20)

            Text(original.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))
                .font(.system(size: 14))
                .foregroundStyle(Color("Entry dates Color"))
                .padding(.top, 8)

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
        .interactiveDismissDisabled(hasChanges)
        .onAppear { focusedField = .title }
        .overlay(alignment: .top) {
            if showDiscardAlert {
                VStack(spacing: 10) {
                    Text("Are you sure you want to discard changes on this journal?")
                        .font(.system(size: 15))
                        .foregroundStyle(.white.opacity(0.9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 6)
                        .padding(.bottom, 4)

                    Button {
                        dismiss()
                    } label: {
                        Text("Discard Changes")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color("Delete action Color"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .glassEffect(.clear, in: Capsule())
                    }

                    Button {
                        showDiscardAlert = false
                    } label: {
                        Text("Keep Editing")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .glassEffect(.clear, in: Capsule())
                    }
                }
                .padding(16)
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 32))
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showDiscardAlert)
    }
}

#Preview {
    EditJournalView { _ in }
}
