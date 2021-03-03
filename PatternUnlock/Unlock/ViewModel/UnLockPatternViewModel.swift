import Foundation
import Combine

protocol UnLockPatternViewModelInput {

}

protocol UnLockPatternViewModelOutput {

}

final class UnLockPatternViewModel: ObservableObject, Identifiable {

	let unlockKeyA = "137546"
	let unlockKeyB = "24785103"
	let unlockDots: [UnlockDotModel]
	let headerText = NSLocalizedString("Try to match one of displayed keys to go to next screen", comment: "")
	let title = NSLocalizedString("Unlock to navigate", comment: "")


	private var touchedDots = [UnlockDotIdentifier]()
	//inputs
	@Published var enteredPattern: String = "-.-.-.-.-.-.-"
	@Published var didAppears: Bool = false

	private var enteredKey: String = "" {
		didSet {
			enteredPattern = enteredKey
		}
	}

	init() {
		unlockDots = UnlockDotIdentifier
			.allCases
			.map { UnlockDotModel(identifier: $0) }
	}

	func addDot(identifier: UnlockDotIdentifier) {
		touchedDots.append(identifier)
		enteredKey.append("\(identifier.rawValue)")
	}

	func didStartDrawing() {
		enteredKey = ""
		touchedDots.removeAll()
	}

	func didFinishDrawing() {
		enteredKey = touchedDots.map { "\($0.rawValue)" }.joined(separator: " ")

		switch enteredKey {
			case unlockKeyA:
				unlockUseCaseA()
			case unlockKeyB:
				unlockUseCaseB()

			default:
				return
		}

	}

	private func unlockUseCaseA() {

		print("unlockUseCaseA")

	}

	private func unlockUseCaseB() {
		print("unlockUseCaseB")
	}
}
