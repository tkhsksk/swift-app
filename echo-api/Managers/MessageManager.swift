import Foundation

class MessageManager: ObservableObject {
    @Published var message: String?
    @Published var type: MessageType = .info

    enum MessageType {
        case info, success, warning, error
    }

    func show(_ message: String, type: MessageType = .info) {
        self.message = message
        self.type = type
    }

    func clear() {
        self.message = nil
    }
}

