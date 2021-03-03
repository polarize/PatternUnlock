import UIKit

final class UnlockView: UIView {

	var enteredKeyAction: ((String)->Void)?

	var viewModel: UnlockViewModelIO
	var canvasView: CanvasView?

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
		let canvasView = MainView.canvasViewConstraints(in: self, viewModel: viewModel)
		viewModel.input.patternSize(height: Float(canvasView.frame.height), width: Float(canvasView.frame.width))
		self.canvasView = canvasView
		self.canvasView?.setupSubviews(with: viewModel.output.allDots)
	}
}

extension MainView {
	static func canvasViewConstraints(in parent: UIView, viewModel: UnlockViewModelIO) -> CanvasView {
		let canvas = CanvasView(viewModel: viewModel)
		canvas.backgroundColor = .red

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
