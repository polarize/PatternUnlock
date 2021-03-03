import UIKit

final class UnlockViewController: UIViewController {

	let mainView = UnlockView()

	let viewModel: UnlockViewModel

	init(with viewModel: UnlockViewModel) {
		self.viewModel = viewModel
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
	}

}
