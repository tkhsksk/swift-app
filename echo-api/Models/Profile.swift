import Foundation

struct Profile: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let email: String
    let status: String
    let createdAt: Date?
    let updatedAt: Date?
    // サーバーのレスポンス形式に合わせて追加
}
