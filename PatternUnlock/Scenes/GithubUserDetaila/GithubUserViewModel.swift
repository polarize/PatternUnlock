import Foundation

final class GithubUserViewModel {

	let user: UserResponse

	var avatarURL: URL? {
		return URL(string: user.avatarUrl ?? "")
	}

	init(_ user: UserResponse) {
		self.user = user
	}
}
