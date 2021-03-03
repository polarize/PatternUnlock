import UIKit

final class GithubSearchCoordinator: Coordinator {

	let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let viewModel = GithubSearchViewModel()
		let viewController = GithubSearchViewController(with: viewModel)
		navigationController.pushViewController(viewController, animated: true)
	}

}

