import Foundation
import Combine

protocol GithubSearchViewModelDelegate: AnyObject {
	func githubSearchViewModel(_ viewModel: GithubSearchViewModel, didSelect user: UserResponse)
}
final class GithubSearchViewModel {

	@Published var users = [UserResponse]()

	weak var delegate: GithubSearchViewModelDelegate?

	func didTapSearch(_ username: String) {
		fetchUsers(username)
	}

	func didSelectUser(at index: IndexPath) {
		guard index.row < users.count else {
			return
		}

		let user = users[index.row]
		delegate?.githubSearchViewModel(self, didSelect: user)
	}

	func fetchUsers(_ username: String) {

		NetworkingService.requestUsers(userName: username) { [weak self] result in
			switch result {
				case .success(let users):
					self?.users = users
				case .failure(let error):
					print(error)
			}

		}
	}
}
