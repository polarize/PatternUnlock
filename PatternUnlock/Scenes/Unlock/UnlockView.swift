import UIKit

final class UnlockView: UIView {

	lazy var button: UIButton = {

		let frame = CGRect(x: 30, y: 200, width: 300, height: 60)
		let button = UIButton(frame: frame)
		button.setTitle("NEXT >>>>>", for: .normal)
		button.backgroundColor = .green
		return button
	}()

	var enteredKeyAction: ((String)->Void)?

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

	func setupSubviews() {
		addSubview(button)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
	}

	@objc
	func buttonTapped() {
		enteredKeyAction?(Challenge.userSearch.rawValue)
	}
}
