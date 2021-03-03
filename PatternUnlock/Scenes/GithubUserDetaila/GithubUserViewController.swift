import UIKit

final class GithubUserViewController: UIViewController {

	let mainView = GithubUserView()

	let viewModel: GithubUserViewModel

	init(with viewModel: GithubUserViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}

