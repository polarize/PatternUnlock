import Foundation

enum Challenge: String {
	case userSearch //= "0123456"
	case userDetails //= "97326635"
}

protocol UnlockViewModelDelegate: AnyObject {
	func unlockViewModel(_ viewModel: UnlockViewModel, didEnterChallenge challenge: Challenge)
}

protocol UnlockViewModelIO {
	var input: UnlockViewModelInput { get }
	var output: UnlockViewModelOutput { get }
}

protocol UnlockViewModelInput {
	func handleEnteredPattern(_ key: String)
	func didTouchDot(_ dot: DotViewModel)
	func clearAllDots()
	func patternSize(height: Float, width: Float)
}

protocol UnlockViewModelOutput {
	var touchedDots: [DotViewModel] { get }
}

extension UnlockViewModel: UnlockViewModelIO {
	var input: UnlockViewModelInput { return self  }
	var output: UnlockViewModelOutput { return self }
}

enum Constant {
	static var dotKeyMaxLength = 8
	static var maxSizeWidth = 3
	static var maxSizeHeight = 3
}

final class UnlockViewModel: UnlockViewModelOutput, UnlockViewModelInput {

	weak var delegate: UnlockViewModelDelegate?

	let challengeA: Challenge = .userSearch
	let challengeB: Challenge = .userDetails

	var touchedDots = [DotViewModel]()

	private var maxDistanceAllowed: Float = 0

	func patternSize(height: Float, width: Float) {
		maxDistanceAllowed = (height * width)/2
	}

	func handleEnteredPattern(_ key: String) {
		guard let challenge = Challenge(rawValue: key) else {
			return
		}

		delegate?.unlockViewModel(self, didEnterChallenge: challenge)
	}

	func didTouchDot(_ dot: DotViewModel) {

		guard touchedDots.contains(dot) == false else {
			return
		}

		guard touchedDots.count < Constant.dotKeyMaxLength else {
			return
		}

		guard maxDistanceAllowed > 0 else {
			fatalError()
		}

		if let last = touchedDots.last, last != dot, let lastPoint = last.point, let newPoint = dot.point {
			let distance = distanceSquared(from: lastPoint, to: newPoint)

			guard distance <= maxDistanceAllowed else {
				return
			}
		}

		touchedDots.append(dot)
		dot.isHighlighted = true
	}

	func clearAllDots() {
		for dot in touchedDots {
			dot.isHighlighted = false
		}
		touchedDots.removeAll()
	}
}

extension UnlockViewModel {
	func distanceSquared(from: Point, to: Point) -> Float {
		return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
	}
}
