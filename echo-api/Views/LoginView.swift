import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager
    @State private var email = "user@example.com"
    @State private var password = "Password123"
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
        NavigationView {
            ZStack {
                Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.8)
                .background(Color.black)
                Spacer() // 上部スペース
                VStack(spacing: 50) {
                    VStack(spacing: 30) {
                        Image("logo")
                            .resizable()
                            .frame(
                                width: 180,
                                height: 50,
                                alignment: .center
                            )
                        
                        // Text("Welcome to ksk318.me")
                    }
                    VStack(spacing: 40) {
                        VStack(spacing: 15) {
                            VStack{
                                Text("メールアドレス")
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 60)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                TextField("メールアドレス", text: $email)
                                    .padding(13)
                                    .background(Color(red: 242/256, green: 241/256, blue: 256/256))
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                            }
                            VStack{
                                Text("パスワード")
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 60)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                SecureField("パスワード", text: $password)
                                    .padding(13)
                                    .background(Color(red: 242/256, green: 241/256, blue: 256/256))
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                            }
                        }
                        
                        VStack {
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
                        }
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(width: 280)
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: 350)
                }
//              アラートの表示
                .alert(greeting[0], isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
                } message: {
                Text(greeting[1])
                }
                .padding()
                Spacer() //  下部スペース
            }
        }
    }
}

#Preview {
    LoginView()
}
