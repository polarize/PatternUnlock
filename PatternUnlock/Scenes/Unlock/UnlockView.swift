import UIKit

final class UnlockView: UIView {

	lazy var challenge1Button: UIButton = {
		let frame = CGRect(x: 30, y: 200, width: 300, height: 60)
		let button = UIButton(frame: frame)
		button.setTitle("Challenge A", for: .normal)
		button.backgroundColor = .green
		return button
	}()

	lazy var challenge2Button: UIButton = {
		let frame = CGRect(x: 30, y: 300, width: 300, height: 60)
		let button = UIButton(frame: frame)
		button.setTitle("Challenge B", for: .normal)
		button.backgroundColor = .blue
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
		addSubview(challenge1Button)
		addSubview(challenge2Button)
		challenge1Button.addTarget(self, action: #selector(button1Tapped), for: .touchDown)
		challenge2Button.addTarget(self, action: #selector(button2Tapped), for: .touchDown)
	}

	@objc
	func button1Tapped() {
		enteredKeyAction?(Challenge.userSearch.rawValue)
	}

	@objc
	func button2Tapped() {
		enteredKeyAction?(Challenge.userDetails.rawValue)
	}
}
