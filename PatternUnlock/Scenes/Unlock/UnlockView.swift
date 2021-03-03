import UIKit

final class UnlockView: UIView {

	init() {
		super.init(frame: .zero)
		setup()
		setupSubviews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setup() {
		backgroundColor = .red
	}

	func setupSubviews() {}
}
