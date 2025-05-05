import SwiftUI

struct WelcomeView: View {
//    ここからページの本体
    var body: some View {
        NavigationView {
            VStack {
                Spacer() // 上部スペース
                VStack(spacing: 50) {
                    VStack(spacing: 30) {
                        Image("logo")
                            .resizable()
                            .frame(
                                width: 120,
                                height: 105,
                                alignment: .center
                            )
                        
                        // Text("Welcome to ksk318.me")
                        Text("すでにユーザー登録済みの方は\nログインに進んでください")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 60)
                    }
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: LoginView()) {
                            Text("ログイン")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(13)
                                .frame(width: 290)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: LoginView()) {
                            Text("ユーザー登録")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(13)
                                .frame(width: 290)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2))
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
