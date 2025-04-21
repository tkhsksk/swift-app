import Foundation

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var sessionID: String? // ← 必ずここに定義すること！

    init() {
        if let storedSessionID = APIService.shared.sessionID {
            self.sessionID = storedSessionID
            self.isLoggedIn = true
        }
    }

    func updateSessionID(_ newSessionID: String) {
        self.sessionID = newSessionID
        self.isLoggedIn = true
    }

    func logout() {
        APIService.shared.logout()
        self.sessionID = nil
        self.isLoggedIn = false
    }
}
