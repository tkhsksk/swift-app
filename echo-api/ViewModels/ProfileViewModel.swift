import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadProfile() {
        isLoading = true
        APIService.shared.fetchUserProfile { result in
            self.isLoading = false
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            print(self.profile)
        }
    }
}
