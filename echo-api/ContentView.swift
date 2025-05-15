import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var messageManager: MessageManager

    var body: some View {
        if session.isLoggedIn {
            HomeView()
            .onAppear {
                messageManager.clear()
            }
        } else {
            WelcomeView()
            .onAppear {
                messageManager.clear()
            }
        }
    }
}
