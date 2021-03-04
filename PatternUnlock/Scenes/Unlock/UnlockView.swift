import UIKit

final class UnlockView: UIView {

	private lazy var challengeATitleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .black
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		return label
	}()

	private lazy var challengeBTitleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .black
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		return label
	}()

	private lazy var challengeALabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .red
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		return label
	}()

	private lazy var challengeBLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .red
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		return label
	}()
	
	var enteredKeyAction: ((String)->Void)?

	var viewModel: UnlockViewModelIO
	var canvasView: CanvasView!

	init(viewModel: UnlockViewModelIO) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		setup()
		setupSubviews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setup() {
		backgroundColor = .white
	}

	func setupSubviews() {
		canvasView = MainView.canvasViewConstraints(in: self, viewModel: viewModel)
		self.canvasView.setupSubviews(with: viewModel.output.allDots)

		challengeALabelConstraints()
		challengeBLabelConstraints()
		challengeALabel.text = viewModel.output.challengeA.rawValue
		challengeBLabel.text = viewModel.output.challengeB.rawValue

		challengeATitleLabel.text = "Challenge A"
		challengeATitleLabelConstraints()

		challengeBTitleLabel.text = "Challenge B"
		challengeBTitleLabelConstraints()
	}


	private func challengeATitleLabelConstraints() {
		addSubview(challengeATitleLabel)
		challengeATitleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			challengeATitleLabel.topAnchor.constraint(equalTo: challengeALabel.topAnchor, constant: -20),
			challengeATitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

		])
	}

	private func challengeALabelConstraints() {
		addSubview(challengeALabel)
		challengeALabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			challengeALabel.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: -100),
			challengeALabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

		])
	}


	private func challengeBLabelConstraints() {
		addSubview(challengeBLabel)
		challengeBLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			challengeBLabel.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: -100),
			challengeBLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
		])
	}

	private func challengeBTitleLabelConstraints() {
		addSubview(challengeBTitleLabel)
		challengeBTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			challengeBTitleLabel.topAnchor.constraint(equalTo: challengeBLabel.topAnchor, constant: -20),
			challengeBTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
		])
	}
}

extension MainView {
	static func canvasViewConstraints(in parent: UIView, viewModel: UnlockViewModelIO) -> CanvasView {
		let canvas = CanvasView(viewModel: viewModel)
		canvas.backgroundColor = .white

		parent.addSubview(canvas)
		canvas.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			canvas.centerXAnchor.constraint(equalTo: parent.centerXAnchor),

			canvas.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -100),

			canvas.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: -20),
			canvas.heightAnchor.constraint(equalTo: parent.widthAnchor, constant: -20)
		])

		return canvas
	}
}
