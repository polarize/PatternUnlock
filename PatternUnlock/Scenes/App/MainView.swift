import UIKit

final class MainView: UIView {

	init() {
		super.init(frame: .zero)
		setup()
		setupSubviews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setup() {
		backgroundColor = .blue
	}

	func setupSubviews() {}

}

