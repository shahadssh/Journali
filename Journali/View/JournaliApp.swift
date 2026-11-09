import SwiftUI

@main
struct JournaliApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    JournalListView()
                }
            }
            .task {
                try? await Task.sleep(for: .seconds(2))
                withAnimation { showSplash = false }
            }
        }
    }
}
