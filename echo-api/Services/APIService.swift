import Foundation
import KeychainAccess

class APIService {
    static let shared = APIService()
    private let keychain = Keychain(service: "com.yourapp.identifier")
    struct UserResponse: Codable {
        let message: String
        let user: Profile
    }

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
            print("API_URLをInfo.plist から取得できませんでした")
            return
        }

        guard let url = URL(string: baseURL + "/auth/user/login") else {
            print("URL生成に失敗しました: \(baseURL + "/auth/user/login")")
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
    
    func fetchUserProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
              let url = URL(string: baseURL + "/authed/user/profiles") else {
            print("URL生成に失敗")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // セッションIDがあれば、ヘッダーにSession-IDを追加
        if let sessionID = self.sessionID {
            request.addValue(sessionID, forHTTPHeaderField: "Session-ID")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data", code: -1)))
                }
                return
            }

            do {
                let decoder = JSONDecoder()

                // ISO8601DateFormatter を使って日付を変換
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                
                decoder.dateDecodingStrategy = .custom { decoder in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)
                    guard let date = formatter.date(from: dateStr) else {
                        throw DecodingError.dataCorruptedError(
                            in: container,
                            debugDescription: "Invalid date format: \(dateStr)"
                        )
                    }
                    return date
                }

                decoder.keyDecodingStrategy = .convertFromSnakeCase

                // ← user を含む全体のレスポンスをまずデコード
                let userResponse = try decoder.decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(userResponse.user))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }

            print(String(data: data, encoding: .utf8) ?? "Invalid data")
        }.resume()
    }


    func logout() {
        sessionID = nil
    }
}
