import UIKit

final class GithubUserCoordinator: Coordinator {

	let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let viewModel = GithubUserViewModel()
		let viewController = GithubUserViewController(with: viewModel)
		navigationController.pushViewController(viewController, animated: true)
	}

}

