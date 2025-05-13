import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var messageManager: MessageManager
    @State private var name = "hoge"
    @State private var email = "hoge+021@example.com"
    @State private var password = "Password123"
    @State private var registerFailed = false
    @State private var isRegistered = false
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    var greeting: [String] {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            case 9..<18: return [
                "登録に失敗しました",
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
        NavigationStack {
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
                                Text("ユーザー名")
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 60)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                TextField("ユーザー名", text: $name)
                                    .padding(13)
                                    .background(Color(red: 242/256, green: 241/256, blue: 256/256))
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                            }
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
                            Button("登録") {
                                registerFailed = false
                                AuthAPI.shared.registerUser(
                                    name: name,
                                    email: email,
                                    password: password,
                                    messageManager: messageManager
                                ) { success in
                                    if success {
                                        isRegistered = true
                                    } else {
                                        registerFailed = true
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
                
                .navigationDestination(isPresented: $isRegistered) {
                    LoginView()
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
        
//        戻るボタンのカスタマイズ
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("初回画面")
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
