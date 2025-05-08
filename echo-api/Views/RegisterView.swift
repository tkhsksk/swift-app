import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var session: SessionManager
    @State private var name = "hoge"
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
            Text("ユーザー登録").font(.largeTitle)
            TextField("ユーザー名", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            TextField("メールアドレス", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("パスワード", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("登録") {
                loginFailed = false
                AuthAPI.shared.registerUser(name: name, email: email, password: password) { success in
                    if success {
                        if let sessionID = AuthAPI.shared.sessionID {
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

#Preview {
    LoginView()
}
