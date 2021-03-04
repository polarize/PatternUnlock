import UIKit

final class ViewController: UIViewController {

	let mainView = MainView()

	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
