import SwiftUI

struct EmptyStateView: View {
   
    @State private var searchText = ""
    @State private var speech = SpeechRecognizer()
    
    var body: some View {
        ZStack{
            Color("MainScreenBackgroundColor")
            .ignoresSafeArea()
           
            VStack {
                    HStack {
                     Text("Journal")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color("MainHeadings&JournalContentColor"))

                    Spacer()

                    HStack(spacing: 0) {
                     Button { } label: {
                     Image(systemName: "line.3.horizontal.decrease")
                        .frame(width: 48, height: 48) }
                        
                     Button { } label: {
                     Image(systemName: "plus")
                    .frame(width: 48, height: 48) } }
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .glassEffect(.clear, in: Capsule())
                            }
                            .padding(.horizontal, 20)

                            Spacer()
                        }
            
            
            VStack(spacing: 0) {
            
            Image("Illustration")
                .resizable()
                .scaledToFit()
                .frame(width:151.39,height: 97.32)
            
            Text("Begin Your Journal")
                .font(.system(size:24,weight:.bold))
                .foregroundStyle(Color("JournalTitles&EmptyStateHeadingColor"))
                .padding(.top,28.62)
                
                
            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size:18, weight:.light))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("MainHeadings&JournalContentColor"))
                .padding(.top, 16)
        }
            
           
            
            VStack {
                       Spacer()

                       HStack(spacing: 8) {
                           Image(systemName: "magnifyingglass")
                               .foregroundStyle(.white)

                           TextField("Search", text: $searchText)
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
                   }
            .onChange(of: speech.transcript) { _, newValue in
                searchText = newValue
            }
        }
    }
}
#Preview {
    EmptyStateView()
}
