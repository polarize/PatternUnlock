import UIKit

final class GithubSearchCoordinator: Coordinator {

	let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let viewModel = GithubSearchViewModel()
		let storyboard = UIStoryboard(name: "GithubSearchViewController", bundle: nil)
		let viewController = storyboard.instantiateInitialViewController() as? GithubSearchViewController//GithubSearchViewController(with: viewModel)
		viewController?.viewModel = viewModel
		navigationController.pushViewController(viewController!, animated: true)
	}

}

