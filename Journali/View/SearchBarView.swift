import SwiftUI

struct SearchBarView: View {
    @Bindable var viewModel: JournalViewModel
    @State private var speech = SpeechRecognizer()

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)

            TextField("Search", text: $viewModel.searchText)
                .foregroundStyle(.white)

            Button {
                if speech.isListening {
                    speech.stop()
                } else {
                    speech.start()
                }
            } label: {
                Image(systemName: speech.isListening ? "mic.fill" : "mic")
                    .foregroundStyle(speech.isListening ? .red : .white)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .glassEffect(.clear, in: Capsule())
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .onChange(of: speech.transcript) { _, newValue in
            viewModel.searchText = newValue
        }
    }
}
