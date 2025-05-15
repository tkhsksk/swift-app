import SwiftUI

struct MyPageView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("読み込み中…")
            } else if let profile = viewModel.profile {
                VStack(alignment: .leading, spacing: 12) {
                    Text("ユーザー名: \(profile.name)")
                    Text("メールアドレス: \(profile.email)")
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("エラー: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                Text("プロフィールが見つかりませんでした")
            }
        }
        .onAppear {
            viewModel.loadProfile()
        }
        .navigationTitle("マイページ")
    }
}
