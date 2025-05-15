import Foundation

struct Profile: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let status: String
    let created_at: Date?
    let updated_at: Date?
    // サーバーのレスポンス形式に合わせて追加
}
