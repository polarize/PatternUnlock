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

struct UnlockDotModel {
	let identifier: UnlockDotIdentifier
	let normalImageName = "dot_off.png"
	let highlightedImageName = "dot_on.png"
	let isHighlighted = false
}

struct Point: Equatable {
	let x: Float
	let y: Float
}
