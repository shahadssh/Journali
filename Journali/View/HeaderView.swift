import SwiftUI

struct HeaderView: View {
    @Bindable var viewModel: JournalViewModel
    let onAdd: () -> Void

    var body: some View {
        HStack {
            Text("Journal")
                .font(.system(size: 34, weight: .bold))
//                .foregroundStyle(Color("MainHeadings&JournalContentColor"))

            Spacer()

            HStack(spacing: 0) {
                Menu {
                    Button("Sort by Bookmark") {
                        viewModel.showBookmarkedOnly = true
                    }
                    Button("Sort by Entry Date") {
                        viewModel.showBookmarkedOnly = false
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .frame(width: 48, height: 48)
                }
                Button {
                    onAdd()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 48, height: 48)
                }
            }
            .font(.system(size: 22))
            .foregroundStyle(.white)
            .glassEffect(.clear, in: Capsule())
        }
        .padding(.horizontal, 20)
    }
}
