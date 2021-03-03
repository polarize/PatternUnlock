import UIKit

final class UnlockViewController: UIViewController {

	
	let mainView: UnlockView

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

extension UnlockViewController {

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//		clearDotViews()
//		viewModel.didStartDrawing()
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let point = touches.first?.location(in: mainView) else {
			return
		}

		guard let touched = mainView.hitTest(point, with: event) else {
			return
		}

		if let dotView = touched as? DotViewModel {
//			addDotView(dotView)
		}
//		drawLineFromLastDot(to: point)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

//		clearDotViews()
//		viewModel.didFinishDrawing()
	}
}
