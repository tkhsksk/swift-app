import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager
    @State private var email = "user@example.com"
    @State private var password = "password123"
    @State private var loginFailed = false
    @State private var isLoggedIn = false
    @State private var showAlert = false
    var greeting: [String] {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            case 9..<18: return [
                "ログイン情報が違います",
                "メールアドレスもしくはパスワードをご確認ください"
            ]
            default: return [
                "APIが稼働していません",
                "9:00〜18:00の間に再度お試しください"
            ]
        }
    }
//    ここからページの本体
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
                            session.updateSessionID(sessionID) // セッションをアップデート
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
//        アラートの表示
        .alert(greeting[0], isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(greeting[1])
        }
        .padding()
    }
}
