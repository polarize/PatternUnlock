import UIKit

protocol Coordinator {
	var navigationController: UINavigationController { get }
	func start()
}


final class AppCoordinator: Coordinator {

	let navigationController: UINavigationController

	var window: UIWindow

	var coordinators = [Coordinator]()

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
		coordinator.start()
		coordinators.append(coordinator)

	}

	func startUserDetails() {
		let coordinator = GithubUserCoordinator(navigationController: navigationController)
		coordinator.start()
		coordinators.append(coordinator)
	}
}

extension AppCoordinator: UnlockCoordinatorDelegate {

	func unlockCoordinator(_ coordinator: UnlockCoordinator, didFinishWith challenge: Challenge) {
		switch challenge {
			case .userSearch: startUserSearch()
			case .userDetails: startUserDetails()
		}
	}
}
