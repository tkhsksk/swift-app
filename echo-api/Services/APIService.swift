import Foundation
import KeychainAccess

class APIService {
    static let shared = APIService()
    private let keychain = Keychain(service: "com.yourapp.identifier")

    var sessionID: String? {
        get { keychain["session_id"] }
        set {
            if let id = newValue {
                keychain["session_id"] = id
            } else {
                try? keychain.remove("session_id")
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String else {
            print("API_URL を Info.plist から取得できませんでした")
            return
        }

        guard let url = URL(string: baseURL + "/login") else {
            print("URL生成に失敗しました: \(baseURL + "/login")")
            return
        }


        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let message = json["message"] as? String,
                  let sessionId = json["session_id"] as? String else {
                DispatchQueue.main.async { completion(false) }
                return
            }

            if message == "ログイン成功" {
                self.sessionID = sessionId
                DispatchQueue.main.async { completion(true) }
            } else {
                DispatchQueue.main.async { completion(false) }
            }
        }.resume()
    }

    func logout() {
        sessionID = nil
    }
}
