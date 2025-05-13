import Foundation

class AuthAPI {
    static let shared = AuthAPI()

    func registerUser(
        name: String,
        email: String,
        password: String,
        messageManager: MessageManager, // ← 追加
        completion: @escaping (Bool) -> Void
    ) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String else {
            print("API_URLをInfo.plistから取得できませんでした")
            return
        }

        guard let url = URL(string: baseURL + "/auth/user/register") else {
            print("URL生成に失敗しました: \(baseURL + "/auth/user/register")")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["name": name, "email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let message_api = json["message"] as? String else {
                DispatchQueue.main.async {
                    messageManager.show("通信エラーが発生しました", type: .error)
                    completion(false)
                }
                return
            }

            DispatchQueue.main.async {
                if message_api == "登録成功" {
                    messageManager.show("登録成功！", type: .success)
                    completion(true)
                } else {
                    messageManager.show("登録失敗", type: .error)
                    completion(false)
                }
            }
        }.resume()
    }
}
