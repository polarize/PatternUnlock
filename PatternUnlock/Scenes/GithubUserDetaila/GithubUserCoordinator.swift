import UIKit

final class GithubUserCoordinator: Coordinator {

	let navigationController: UINavigationController

	private let viewModel: GithubUserViewModel

	init(navigationController: UINavigationController, user: UserResponse) {
		self.navigationController = navigationController
		viewModel = GithubUserViewModel(user)
	}

	func start() {
		let storyboard = UIStoryboard(name: "GithubUserViewController", bundle: nil)
		let viewController = storyboard.instantiateInitialViewController() as? GithubUserViewController
		viewController?.viewModel = viewModel
		navigationController.pushViewController(viewController!, animated: true)
	}
}

