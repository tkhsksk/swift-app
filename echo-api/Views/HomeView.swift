import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @State private var displayedSessionID: String = ""
    @State private var showAlert = false

    var body: some View {
        AnyView(TabbarView())
//        画面が表示されたら実行
        .onAppear {
            if let sessionID = session.sessionID {
                displayedSessionID = sessionID
                showAlert = true
            }
        }
//        アラートの表示
//        .alert("ログインに成功しました", isPresented: $showAlert) {
//            Button("OK", role: .cancel) { }
//        } message: {
//            Text("セッションID: \(displayedSessionID.isEmpty ? "未取得" : displayedSessionID)")
//        }
    }
}
