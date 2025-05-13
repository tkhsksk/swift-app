import SwiftUI

@main
struct YourAppApp: App {
    @StateObject var session = SessionManager()
    @StateObject var messageManager = MessageManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
                .environmentObject(messageManager)
        }
    }
}
