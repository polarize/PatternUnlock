import Foundation
import Combine

enum UnlockDotIdentifier: Int, CaseIterable {
	case first = 0
	case second
	case third
	case fourth
	case fifth
	case sixth
	case seventh
	case eighth
	case ninth
}


struct Point: Equatable {
	let x: Float
	let y: Float
}

final class DotViewModel: Equatable {
	static func == (lhs: DotViewModel, rhs: DotViewModel) -> Bool {
		return lhs.identifier == rhs.identifier
	}

	let identifier: Int
	let normalImageName = "dot_off.png"
	let highlightedImageName = "dot_on.png"

	var isHighlighted: Bool = false

	var point: Point?

	init(identifier: Int) {
		self.identifier = identifier
	}

}
