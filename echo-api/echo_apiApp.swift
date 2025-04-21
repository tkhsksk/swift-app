import SwiftUI

@main
struct YourAppApp: App {
    @StateObject var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
        .environmentObject(session)
    }
}
