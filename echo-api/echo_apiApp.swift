import SwiftUI

@main
struct YourAppApp: App {
    @StateObject var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}
