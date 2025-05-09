import SwiftUI

struct WelcomeView: View {
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
                        Text("すでにユーザー登録済みの方は\nログインに進んでください")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 60)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: LoginView()) {
                            Text("ログイン")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(14)
                                .frame(width: 290)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("ユーザー登録")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding(13)
                                .frame(width: 290)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1))
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
