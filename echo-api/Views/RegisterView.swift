import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var messageManager: MessageManager
    @EnvironmentObject var session: SessionManager
    @State private var name = "hoge"
    @State private var email = "hoge@example.com"
    @State private var password = "Password123"
    @State private var registerFailed = false
    @State private var isRegistered = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Environment(\.dismiss) var dismiss
    
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
                            Button(action: {
                                registerFailed = false
                                AuthAPI.shared.registerUser(
                                    name: name,
                                    email: email,
                                    password: password,
                                    messageManager: messageManager
                                ) { success, message in
                                    if success {
                                        isRegistered = true
                                        session.registered(email: email)
                                    } else {
                                        isRegistered = false
                                        alertTitle = "登録に失敗しました"
                                        alertMessage = message
                                        registerFailed = true
                                        showAlert = true
                                    }
                                }
                            }) {
                                Text("登録")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .frame(width: 280)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .frame(maxWidth: 350)
                }
                
                .navigationDestination(isPresented: $isRegistered) {
                    LoginView()
                    .navigationBarBackButtonHidden(true) 
                }
                
//              アラートの表示
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(alertMessage)
                }
                .padding()
                
                Spacer() //  下部スペース
            }
        }
        
//        alertメッセージの削除
        .onDisappear {
            messageManager.clear()
        }
    }
}

#Preview {
    RegisterView()
}
