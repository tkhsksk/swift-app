import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager
    @State private var email = "user@example.com"
    @State private var password = "password123"
    @State private var loginFailed = false
    @State private var isLoggedIn = false
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("ログイン").font(.largeTitle)

            TextField("メールアドレス", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("パスワード", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("ログイン") {
                loginFailed = false
                APIService.shared.login(email: email, password: password) { success in
                    if success {
                        if let sessionID = APIService.shared.sessionID {
                            session.updateSessionID(sessionID) // ✅ ここ追加！！
                        }
                        isLoggedIn = true
                    } else {
                        loginFailed = true
                        showAlert = true
                    }
                }
            }
            .padding(.top)
        }
        .alert("ログイン情報が違います", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        .padding()
    }
}
