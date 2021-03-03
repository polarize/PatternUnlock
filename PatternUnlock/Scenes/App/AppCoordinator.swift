import UIKit

final class AppCoordinator {

	let navigationController: UINavigationController

	var unlockCoordinator: UnlockCoordinator?
	var window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
		navigationController = UINavigationController()
		window.rootViewController = navigationController
	}

	func start() {
		unlockCoordinator = UnlockCoordinator(navigationController: navigationController)
		unlockCoordinator?.start()
		window.makeKeyAndVisible()
	}
}
