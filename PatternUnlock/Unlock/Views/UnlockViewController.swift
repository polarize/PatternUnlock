import UIKit
import Combine

final class UnlockViewController: UIViewController {

	@IBOutlet weak var drawView: PatternLockView!

	@IBOutlet weak var firstKeyLabel: UILabel!
	@IBOutlet weak var secondKeyLabel: UILabel!
	@IBOutlet weak var enteredKeyLabel: UILabel! {
		didSet {
			enteredKeyLabel.text = "---------------"
		}
	}

	@IBOutlet weak var headerLabel: UILabel! {
		didSet {
			headerLabel.text = "Header Text"
		}
	}

	var viewModel: UnLockPatternViewModel? = UnLockPatternViewModel()
	var cancellables = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()

		guard let viewModel = viewModel else {
			return
		}

		setup(with: viewModel)
		bind(to: viewModel)

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel?.didAppears = true
	}

	private func setup(with viewModel: UnLockPatternViewModel) {
		enteredKeyLabel.text = viewModel.enteredPattern
		firstKeyLabel.text = viewModel.unlockKeyA

		secondKeyLabel.text = viewModel.unlockKeyB
		headerLabel.text = viewModel.headerText

		for dot in viewModel.unlockDots {
			Static.dotViewConstraints(in: drawView, dotModel: dot)
		}
	}

	private func bind(to viewModel: UnLockPatternViewModel) {
		viewModel
			.objectWillChange
			.sink { [weak self] _ in
				self?.enteredKeyLabel.text = viewModel.enteredPattern
			}
			.store(in: &cancellables)
	}


}

