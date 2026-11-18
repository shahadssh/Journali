import SwiftUI

struct SearchBarView: View {
    @Bindable var viewModel: JournalViewModel

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)

            TextField("Search", text: $viewModel.searchText)
                .foregroundStyle(.white)

        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .glassEffect(.clear, in: Capsule())
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}
