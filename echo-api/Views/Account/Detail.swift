import SwiftUI

struct AccountDetailView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var inputText: String = ""
    
    var body: some View {
        GeometryReader { g in
            VStack {
                Form {
                    Section(header: Text("ユーザー名")) {
                        if viewModel.isLoading {
                            ProgressView("読み込み中…")
                        } else if let profile = viewModel.profile {
//                                Text("ユーザー名: \(profile.name)")
//                                Text("メールアドレス: \(profile.email)")
//                                if let date = profile.createdAt {
//                                    Text("作成日: \(format(date: date))")
//                                }
                            TextField("Enter text here", text: $inputText)
                        } else if let errorMessage = viewModel.errorMessage {
                            Text("エラー: \(errorMessage)")
                                .foregroundColor(.red)
                        } else {
                            Text("プロフィールが見つかりませんでした")
                        }
                    }
                }
                
            }
            .onAppear {
                viewModel.loadProfile()
            }
            .onChange(of: viewModel.profile) { oldProfile, newProfile in
                if let name = newProfile?.name {
                    inputText = name
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print("右上ボタンがタップされました")
                }) {
                    Text("変更する")
                }
            }
        }
    }
}

func format(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    return formatter.string(from: date)
}
