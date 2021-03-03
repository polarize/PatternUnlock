import Foundation

enum Challenge: String {
	case userSearch = "0123456"
	case userDetails = "97326635"
}

protocol UnlockViewModelDelegate: AnyObject {
	func unlockViewModel(_ viewModel: UnlockViewModel, didEnterChallenge challenge: Challenge)
}

final class UnlockViewModel {

	weak var delegate: UnlockViewModelDelegate?

	var challengeA: Challenge = .userSearch
	var challengeB: Challenge = .userDetails


	func handleEnteredPattern(_ key: String) {
		guard let challenge = Challenge(rawValue: key) else {
			return
		}

		delegate?.unlockViewModel(self, didEnterChallenge: challenge)
	}
}
