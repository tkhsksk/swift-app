import Foundation

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var sessionID: String?
    @Published var email: String? = nil

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
    
    // 登録情報を保存するメソッド
    func registered(email: String) {
        self.email = email
    }

    func logout() {
        APIService.shared.logout()
        self.sessionID = nil
        self.isLoggedIn = false
    }
}
