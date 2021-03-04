import Foundation

enum Challenge: String {
	case userSearch = "137546"
	case userDetails = "24785103"
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
	func didTouchDot(_ dot: DotViewModel, at: Point)
	func clearAllDots()
	func startDrawing(in canvasArea: Float)
	func draw(to point: Point)
	func endDrawing()
}

protocol UnlockViewModelOutput {
	var touchedDots: [DotViewModel] { get }
	var allDots: [DotViewModel] { get }

	var touchedDotsPublisher: Published<[DotViewModel]>.Publisher { get }

	var trackPoint: Point? { get }
	var trackPointPublisher: Published<Point?>.Publisher { get }

	var shouldRedraw: Bool { get }
	var shouldRedrawPublisher: Published<Bool>.Publisher { get }

	var challengeA: Challenge { get }
	var challengeB: Challenge { get }
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

	@Published var touchedDots = [DotViewModel]()
	var touchedDotsPublisher: Published<[DotViewModel]>.Publisher { $touchedDots }

	@Published var trackPoint: Point?
	var trackPointPublisher: Published<Point?>.Publisher { $trackPoint }

	@Published var shouldRedraw: Bool = false
	var shouldRedrawPublisher: Published<Bool>.Publisher { $shouldRedraw }

	let allDots: [DotViewModel] = UnlockDotIdentifier
		.allCases
		.map { DotViewModel(identifier: $0.rawValue) }

	private var maxDistanceAllowed: Float = 0

	let headerText = NSLocalizedString("Try to match one of displayed keys to go to next screen", comment: "")
	let title = NSLocalizedString("Unlock to navigate", comment: "")

	@Published var enteredPattern: String = "-.-.-.-.-.-.-"
	private var enteredKey: String = "" {
		didSet {
			enteredPattern = enteredKey
		}
	}
	
	func handleEnteredPattern(_ key: String) {
		clearAllDots()
		shouldRedraw = true
		guard let challenge = Challenge(rawValue: key) else {
			return
		}

		delegate?.unlockViewModel(self, didEnterChallenge: challenge)

	}

	func draw(to point: Point) {
		trackPoint = point
		shouldRedraw = true
	}

	func startDrawing(in canvasArea: Float) {
		maxDistanceAllowed = canvasArea/2
		clearAllDots()
		shouldRedraw = true
	}

	func endDrawing() {
		shouldRedraw = true

		enteredKey = touchedDots.map { "\($0.identifier )" }.joined(separator: "")
		handleEnteredPattern(enteredKey)

	}

	func didTouchDot(_ dot: DotViewModel, at point: Point) {

		guard touchedDots.contains(dot) == false else {
			return
		}

		guard touchedDots.count < Constant.dotKeyMaxLength else {
			return
		}

		guard maxDistanceAllowed > 0 else {
			fatalError()
		}

		if let last = touchedDots.last, last != dot, let lastPoint = last.point {

			let distance = distanceSquared(from: lastPoint, to: point)

			guard distance <= maxDistanceAllowed else {
				return
			}
		}

		touchedDots.append(dot)
		dot.point = point
		dot.isHighlighted = true
	}

	func clearAllDots() {
		for dot in touchedDots {
			dot.isHighlighted = false
		}
		touchedDots.removeAll()
//		trackPoint = nil
	}
}

extension UnlockViewModel {
	func distanceSquared(from: Point, to: Point) -> Float {
		return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
	}
}
