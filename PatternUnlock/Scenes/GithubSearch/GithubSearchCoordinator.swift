import UIKit

protocol GithubSearchCoordinatorDelegate: AnyObject {
	func githubSearchCoordinator(_ coordinator: GithubSearchCoordinator, willShowUser user: UserResponse)
}


final class GithubSearchCoordinator: Coordinator {

	let navigationController: UINavigationController

	weak var delegate: GithubSearchCoordinatorDelegate?
	private let viewModel: GithubSearchViewModel
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		viewModel = GithubSearchViewModel()
		viewModel.delegate = self
	}

	func start() {

		let storyboard = UIStoryboard(name: "GithubSearchViewController", bundle: nil)
		let viewController = storyboard.instantiateInitialViewController() as? GithubSearchViewController
		viewController?.viewModel = viewModel
		navigationController.pushViewController(viewController!, animated: true)
	}

}

extension GithubSearchCoordinator: GithubSearchViewModelDelegate {
	func githubSearchViewModel(_ viewModel: GithubSearchViewModel, didSelect user: UserResponse) {
		delegate?.githubSearchCoordinator(self, willShowUser: user)
	}
}
