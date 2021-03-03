import UIKit

final class UnlockCoordinator {

	var navigationController: UINavigationController

//	let viewController: UIViewController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let viewModel = UnlockViewModel()
		let viewController = UnlockViewController(with: viewModel)
		navigationController.setViewControllers([viewController], animated: true)
	}
}
