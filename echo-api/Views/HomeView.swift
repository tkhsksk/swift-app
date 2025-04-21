import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @State private var displayedSessionID: String = ""

    var body: some View {
        VStack {
            Text("ようこそ！").font(.title)
            
            Text("セッションID: \(displayedSessionID.isEmpty ? "未取得" : displayedSessionID)")
                .padding()

//            Button("セッションIDを手動取得") {
//                if let sessionID = session.sessionID {
//                    displayedSessionID = sessionID
//                } else {
//                    displayedSessionID = "セッションが見つかりません"
//                }
//            }
            
            Button("ログアウト") {
                session.logout()
            }
            .padding()
        }
        .padding()
        .onAppear {
            // ✅ 画面表示時にセッションIDを読み込む
            if let sessionID = session.sessionID {
                displayedSessionID = sessionID
            }
        }
    }
}
