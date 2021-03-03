import UIKit

final class AppCoordinator {

	let navigationController: UINavigationController

	init(window: UIWindow) {
		let viewController = ViewController()
		navigationController = UINavigationController(rootViewController: viewController)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}

	func start() {
	
	}
}
