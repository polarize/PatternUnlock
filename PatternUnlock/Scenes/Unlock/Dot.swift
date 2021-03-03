import Foundation

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

struct DotCoordinate {
	let dot: Dot
	let point: Point
}

struct Dot: Equatable {
	let identifier: Int
	let normalImageName = "dot_off.png"
	let highlightedImageName = "dot_on.png"
}

struct Point: Equatable {
	let x: Float
	let y: Float
}

final class DotViewModel: Equatable {
	static func == (lhs: DotViewModel, rhs: DotViewModel) -> Bool {
		return lhs.dot == rhs.dot
	}

	var dot: Dot
	var isHighlighted: Bool = false
	var point: Point?

	init(dot: Dot) {
		self.dot = dot
	}

}
