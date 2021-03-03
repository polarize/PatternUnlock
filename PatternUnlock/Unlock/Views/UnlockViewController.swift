import UIKit
import Combine

final class UnlockViewController: UIViewController {

	private var canvasView: CanvasView?

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

	private var viewModel: UnLockPatternViewModel? = UnLockPatternViewModel()
	private var cancellables = Set<AnyCancellable>()

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

		let canvasView = LayoutHelper.canvasViewConstraints(in: view, viewModel: viewModel)

		for dot in viewModel.unlockDots {
			LayoutHelper.dotViewConstraints(in: canvasView, dotModel: dot)
		}

		self.canvasView = canvasView

	}

	private func bind(to viewModel: UnLockPatternViewModel) {
		viewModel
			.objectWillChange
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.enteredKeyLabel.text = viewModel.enteredPattern
			}
			.store(in: &cancellables)
		
	}


}

