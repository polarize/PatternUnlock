import UIKit

protocol Coordinator {
	var navigationController: UINavigationController { get }
	func start()
}


final class AppCoordinator: Coordinator {

	let navigationController: UINavigationController

	var window: UIWindow

	var coordinators = [Coordinator]()

	private var lastSelectedUser: UserResponse?

	init(window: UIWindow) {
		self.window = window
		navigationController = UINavigationController()
		window.rootViewController = navigationController
	}

	func start() {
		let unlockCoordinator = UnlockCoordinator(navigationController: navigationController)
		unlockCoordinator.delegate = self
		unlockCoordinator.start()
		window.makeKeyAndVisible()
		coordinators.append(unlockCoordinator)
	}

	func startUserSearch() {
		let coordinator = GithubSearchCoordinator(navigationController: navigationController)
		coordinator.delegate = self
		coordinator.start()
		coordinators.append(coordinator)

	}

	func startUserDetails(_ user: UserResponse?) {
		
		guard let user = user else {
			return
		}
		
		let coordinator = GithubUserCoordinator(navigationController: navigationController, user: user)
		coordinator.start()
		coordinators.append(coordinator)
	}
}

extension AppCoordinator: UnlockCoordinatorDelegate {

	func unlockCoordinator(_ coordinator: UnlockCoordinator, didFinishWith challenge: Challenge) {
		switch challenge {
			case .userSearch: startUserSearch()
			case .userDetails: startUserDetails(lastSelectedUser)
		}
	}
}

extension AppCoordinator: GithubSearchCoordinatorDelegate {
	func githubSearchCoordinator(_ coordinator: GithubSearchCoordinator, willShowUser user: UserResponse) {
		lastSelectedUser = user
		startUserDetails(user)
	}
}
