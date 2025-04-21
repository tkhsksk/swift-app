import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        if session.isLoggedIn {
            HomeView()
        } else {
            LoginView()
        }
    }
}
