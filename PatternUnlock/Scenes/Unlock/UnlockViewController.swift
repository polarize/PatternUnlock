import UIKit

final class UnlockViewController: UIViewController {

	let mainView: UnlockView

	var canvasView: CanvasView {
		return mainView.canvasView
	}

	let viewModel: UnlockViewModel

	init(with viewModel: UnlockViewModel) {
		self.viewModel = viewModel
		mainView = UnlockView(viewModel: viewModel)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.enteredKeyAction = {[weak self] key in
			self?.viewModel.handleEnteredPattern(key)
		}
	}

}

extension CGSize {
	var area: Float {
		return Float(height * width)
	}
}

extension CGPoint {
	var toPoint: Point {
		return Point(x: Float(x), y: Float(y))
	}
}

extension Point {
	var toCGPoint: CGPoint {
		return CGPoint(x: CGFloat(x), y: CGFloat(y))
	}
}

extension UnlockViewController {

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		viewModel.input.startDrawing(in: canvasView.frame.size.area)
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let point = touches.first?.location(in: canvasView) else {
			return
		}

		guard let touched = canvasView.hitTest(point, with: event) else {
			return
		}

		if let dotView = touched as? DotView {
			viewModel.input.didTouchDot(dotView.viewModel, at: dotView.center.toPoint)
//			canvasView.addDotView(dotView)
		}
//		canvasView.drawLineFromLastDot(to: point)
		viewModel.input.draw(to: point.toPoint)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

//		clearDotViews()
//		viewModel.didFinishDrawing()
		viewModel.input.endDrawing()
	}
}
