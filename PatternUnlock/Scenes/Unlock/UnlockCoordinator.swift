import UIKit

protocol UnlockCoordinatorDelegate: AnyObject {
	func unlockCoordinator(_ coordinator: UnlockCoordinator, didFinishWith challenge: Challenge)
}


final class UnlockCoordinator: Coordinator {

	weak var delegate: UnlockCoordinatorDelegate?

	var navigationController: UINavigationController

	private let viewModel: UnlockViewModel

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		viewModel = UnlockViewModel()
		viewModel.delegate = self
	}

	func start() {
		let viewController = UnlockViewController(with: viewModel)
		navigationController.setViewControllers([viewController], animated: true)
	}
}

extension UnlockCoordinator: UnlockViewModelDelegate {

	func unlockViewModel(_ viewModel: UnlockViewModel, didEnterChallenge challenge: Challenge) {
		delegate?.unlockCoordinator(self, didFinishWith: challenge)
	}
}
