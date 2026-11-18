import SwiftUI

struct SplashView: View {
    var body: some View {
       
        ZStack {
         
            VStack(spacing: 0) {
                Image("AppIconSplashScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width:81.46,height: 106)
                    
                Text("Journali")
                    .font(.system(size : 42 , weight:.bold ))
                    .padding(.top,21)
                
                Text("Your thoughts, your story")
                    .font(.system(size:18, weight:.light ))
                    .padding(.top,8)
            }
        }
    }
    
}
#Preview {
    SplashView()
}
